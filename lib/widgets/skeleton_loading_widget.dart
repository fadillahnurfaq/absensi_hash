import 'package:flutter/material.dart';

class SkeletonLoadingWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const SkeletonLoadingWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  State<SkeletonLoadingWidget> createState() => _SkeletonLoadingWidgetState();
}

class _SkeletonLoadingWidgetState extends State<SkeletonLoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final shimmerGradient = LinearGradient(
          colors: [
            Colors.grey[400]!,
            Colors.grey[300]!,
            Colors.grey[100]!,
          ],
          stops: const [0.1, 0.4, 0.9],
          begin: Alignment(-1.0 - _controller.value, 0),
          end: Alignment(1.0 - _controller.value, 0),
        );

        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            gradient: shimmerGradient,
          ),
        );
      },
    );
  }
}
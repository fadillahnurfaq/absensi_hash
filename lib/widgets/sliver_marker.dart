import 'package:flutter/material.dart';

class SliverMarker extends StatelessWidget {
  final Widget sliver;

  const SliverMarker({
    super.key,
    required this.sliver
  });

  @override
  Widget build(BuildContext context) {
    return sliver;
  }
}
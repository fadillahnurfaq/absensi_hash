import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/styles.dart';

enum ButtonStyleType { filled, outlined }

class AppButton extends StatelessWidget {
  const AppButton.filled({
    super.key,
    required this.onPressed,
    this.label = "",
    this.labelWidget,
    this.backgroundColor = AppColors.primary,
    this.width,
    this.height = 36.0,
    this.borderRadius = 8.0,
    this.icon,
    this.suffixIcon,
    this.disabled = false,
    this.textStyle,
    this.overlayColor,
  })  : _type = ButtonStyleType.filled,
        sideColor = null,
        sideWidth = null;

  const AppButton.outlined({
    super.key,
    required this.onPressed,
    this.label = "",
    this.labelWidget,
    this.width,
    this.height = 36.0,
    this.borderRadius = 8.0,
    this.icon,
    this.suffixIcon,
    this.disabled = false,
    this.textStyle,
    this.overlayColor,
    this.sideColor = AppColors.gray,
    this.sideWidth = 1.0,
    this.backgroundColor = Colors.transparent,
  })  : _type = ButtonStyleType.outlined;

  final VoidCallback onPressed;
  final String label;
  final Widget? labelWidget;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final Widget? suffixIcon;
  final bool disabled;
  final TextStyle? textStyle;
  final Color? overlayColor;

  final Color? backgroundColor;
  final Color? sideColor;
  final double? sideWidth;

  final ButtonStyleType _type;

  @override
  Widget build(BuildContext context) {
    final isFilled = _type == ButtonStyleType.filled;

    final textColor = isFilled ? Colors.white : Colors.black;

    final child = labelWidget ?? _buildContent(textColor);

    final button = isFilled
        ? ElevatedButton(
            onPressed: disabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              disabledBackgroundColor: AppColors.gray300,
              shadowColor: Colors.transparent,
              overlayColor: overlayColor ?? AppColors.gray400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: child,
          )
        : OutlinedButton(
            onPressed: disabled ? null : onPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: backgroundColor,
              overlayColor: overlayColor ?? AppColors.gray400,
              side: BorderSide(
                color: disabled ? Colors.grey : sideColor!,
                width: sideWidth!,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: child,
          );

    return SizedBox(
      width: width,
      height: height.h,
      child: button,
    );
  }

  Widget _buildContent(Color textColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          if (label.isNotEmpty) const SizedBox(width: 6),
        ],
        if (label.isNotEmpty)
          Text(
            label,
            style: textStyle ?? AppTextStyles.body.copyWith(color: textColor),
          ),
        if (suffixIcon != null) ...[
          if (label.isNotEmpty) const SizedBox(width: 6),
          suffixIcon!,
        ],
      ],
    );
  }
}
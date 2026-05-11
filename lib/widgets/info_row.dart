import 'package:flutter/material.dart';

import '../utils/extensions/string_extensions.dart';
import '../utils/styles.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? value;
  final TextStyle? valueTextStyle;
  final Widget? subtitleWidget;
  
  const InfoRow({super.key, required this.title, this.icon, this.value, this.valueTextStyle, this.subtitleWidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 50,
          child: Row(
            spacing: 4.0,
            children: [
              if (icon != null) Icon(icon, color: AppColors.primary, size: 20.0),
              Flexible(child: Text(title, style: AppTextStyles.body.copyWith(fontWeight: AppTextStyles.semiBold, color: AppColors.gray700))),
            ],
          ),
        ),
        Flexible(
          flex: 50,
          child: subtitleWidget ?? Text(value.getText(), style: valueTextStyle ?? AppTextStyles.body.copyWith(color: AppColors.gray500)),
        )
      ],
    );
  }
}
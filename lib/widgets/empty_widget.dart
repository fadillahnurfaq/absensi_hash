import 'package:absensi_hash/utils/styles.dart';
import 'package:flutter/material.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
    this.textTitle,
    this.isBlue = false,
  });

  final String? textTitle;
  final bool isBlue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        textTitle ?? "There are no data yet",
        textAlign: TextAlign.center,
        style: AppTextStyles.body.copyWith(fontSize: 14, color: AppColors.gray700),
      ),
    );
  }
}
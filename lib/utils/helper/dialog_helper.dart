import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../extensions/context_extensions.dart';
import '../styles.dart';

class DialogHelper {
  DialogHelper._();

  static Future<T?> showBottomSheet<T>({
    required final Widget content,
    final bool isDimissible = true,
    final Color backgroundColor = Colors.white,
    final bool withViewInsetsBottom = true,
    final String? title,
    final TextStyle? titleTextStyle,
    final Widget? titleWidget,
    final ShapeBorder? shape,
    final bool showBar = true,
    final bool fittedHeight = false,
  }) async {
    return await showModalBottomSheet<T>(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      enableDrag: isDimissible,
      useSafeArea: true,
      shape: shape ?? const RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(16.0))),
      constraints: const BoxConstraints(minWidth: double.infinity),
      sheetAnimationStyle: const AnimationStyle(
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.easeOut,
      ),
      builder: (context) {
        return PopScope(
          canPop: isDimissible,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: context.hideKeyboard,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: withViewInsetsBottom ? MediaQuery.of(context).viewInsets.bottom : 0.0,
              ),
              child: ConstrainedBox(
                constraints: fittedHeight ? const BoxConstraints() : BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.3,
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showBar)...[
                      const SizedBox(height: 16),
                      Center(
                        child: Container(
                          width: 40,
                          height: 2,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.gray300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                    if (titleWidget != null  || title != null)...[
                      titleWidget ?? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        child: Text(
                          title ?? "", 
                          style: titleTextStyle ?? AppTextStyles.bodyLarge.copyWith(
                            fontWeight: AppTextStyles.bold
                          )
                        ),
                      ),
                      const Divider(color: AppColors.gray200),
                    ],
                    Flexible(
                      child: SafeArea(
                        child: content,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showSnacbar({required final String message, final SnackBarAction? snackBarAction}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.body.copyWith(
            color: AppColors.white
          ),
        ),
        action: snackBarAction,
      ),
    );
  }


  static void showLoading() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: .1),
      builder: (context) {
        return const PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            insetPadding: EdgeInsets.zero,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/app_styles.dart';

class SnackBarUtils {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    String? actionName,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 1),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppStyles.semi16MainColor.copyWith(
            color: textColor ?? AppColors.whiteColor,
          ),
        ),
        backgroundColor: backgroundColor ?? AppColors.greenColor ,
        duration: duration,
        behavior: SnackBarBehavior.floating,
       shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        action: actionName != null
            ? SnackBarAction(
          label: actionName,
          textColor: textColor ?? AppColors.whiteColor,
          onPressed: () {
            onAction?.call();
          },
        )
            : null,
      ),
    );
  }

  static void showSuccessSnackBar({
    required BuildContext context,
    required String message,
  }) {
    showSnackBar(
      context: context,
      message: message,
      backgroundColor: AppColors.greenColor,
      textColor: AppColors.whiteColor,
    );
  }

  static void showErrorSnackBar({
    required BuildContext context,
    required String message,
  }) {
    showSnackBar(
      context: context,
      message: message,
      backgroundColor: AppColors.redColor,
      textColor: AppColors.whiteColor,
    );
  }
}
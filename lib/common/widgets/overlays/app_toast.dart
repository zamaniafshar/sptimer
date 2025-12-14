import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

abstract final class AppToast {
  static void showSuccess(
    BuildContext context, {
    required String title,
    String? description,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      title: Text(title),
      description: description != null ? Text(description) : null,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  static void showError(
    BuildContext context, {
    required String title,
    String? description,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      title: Text(title),
      description: description != null ? Text(description) : null,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  static void showInfo(
    BuildContext context, {
    required String title,
    String? description,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.flat,
      title: Text(title),
      description: description != null ? Text(description) : null,
      showProgressBar: false,
      alignment: Alignment.bottomCenter,
      icon: Image.asset(
        'assets/images/mini_logo.png',
        width: 24.0,
        height: 24.0,
      ),
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  static void custom(
    BuildContext context, {
    required Widget title,
    Widget? description,
    bool showIcon = false,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.flat,
      title: title,
      description: description,
      showProgressBar: false,
      showIcon: showIcon,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
}

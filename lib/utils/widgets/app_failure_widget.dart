import 'package:flutter/material.dart';
import 'package:sptimer/utils/extensions/extensions.dart';

class AppFailureWidget extends StatelessWidget {
  AppFailureWidget({
    super.key,
    this.e,
    this.errorMessage,
    this.onRetry,
  }) {
    assert(e != null || errorMessage != null);
  }

  final Exception? e;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            errorMessage ?? localization.failureMessage,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(localization.retry),
            ),
          ]
        ],
      ),
    );
  }
}

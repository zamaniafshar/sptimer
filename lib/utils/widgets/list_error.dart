import 'package:flutter/material.dart';

class AppFailureWidget extends StatelessWidget {
  const AppFailureWidget(this.e, {Key? key}) : super(key: key);

  final Exception e;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: Text(
        errorMessage,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}

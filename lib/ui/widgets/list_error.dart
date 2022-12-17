import 'package:flutter/material.dart';

class ListError extends StatelessWidget {
  const ListError(this.errorMessage, {Key? key}) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        errorMessage,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ListError extends StatelessWidget {
  const ListError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        'Something goes wrong.',
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}

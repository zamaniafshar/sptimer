import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
    required this.assetIcon,
    required this.tittle,
    required this.description,
    required this.size,
  }) : super(key: key);

  final double size;
  final String assetIcon;
  final String tittle;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetIcon,
            color: theme.colorScheme.onBackground,
            height: size,
            width: size,
            fit: BoxFit.fill,
          ),
          20.verticalSpace,
          Text(
            tittle,
            style: theme.textTheme.headlineSmall,
          ),
          10.verticalSpace,
          Text(
            description,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

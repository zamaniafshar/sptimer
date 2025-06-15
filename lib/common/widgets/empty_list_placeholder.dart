import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class EmptyListPlaceholder extends StatelessWidget {
  const EmptyListPlaceholder({
    Key? key,
    required this.svgIcon,
    required this.tittle,
    required this.description,
    this.iconSize = 180,
  }) : super(key: key);

  final double iconSize;
  final String svgIcon;
  final String tittle;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgIcon,
            color: theme.colorScheme.onBackground,
            height: iconSize,
            width: iconSize,
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

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/ui/widgets/circle_neumorphic_button.dart';

class TaskInfoWidget extends StatelessWidget {
  const TaskInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Neumorphic(
        padding: EdgeInsets.all(15.r),
        style: NeumorphicStyle(
          color: theme.colorScheme.surface,
          shadowLightColor: Colors.black12,
          depth: 5,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(15.r),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Programming',
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        '0/4',
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _TaskInfoLabel(
                        title: 'W',
                        minutes: 5,
                      ),
                      _TaskInfoLabel(
                        title: 'SB',
                        minutes: 5,
                      ),
                      _TaskInfoLabel(
                        title: 'LB',
                        minutes: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            15.horizontalSpace,
            CircleNeumorphicButton(
              radius: 50.r,
              colors: [
                theme.colorScheme.secondary,
                theme.colorScheme.secondaryContainer,
              ],
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 25.r,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskInfoLabel extends StatelessWidget {
  const _TaskInfoLabel({
    Key? key,
    required this.title,
    required this.minutes,
  }) : super(key: key);

  final String title;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          '$title : ',
          style: theme.primaryTextTheme.labelMedium,
        ),
        Text(
          '$minutes m',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

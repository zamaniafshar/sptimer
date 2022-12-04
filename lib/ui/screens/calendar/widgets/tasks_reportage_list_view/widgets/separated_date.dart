import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/utils/utils.dart';

class SeparatedDate extends StatelessWidget {
  const SeparatedDate({
    Key? key,
    required this.height,
    required this.date,
  }) : super(key: key);

  final double height;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10.w),
            child: CustomPaint(
              painter: _CustomDividerPainter(
                color: Colors.red,
                secondColor: Colors.white,
                radius: 10.r,
              ),
            ),
          ),
          10.verticalSpace,
          Text(
            date.convertToDateString,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CustomDividerPainter extends CustomPainter {
  final double radius;
  final Color color;
  final Color secondColor;
  _CustomDividerPainter({
    required this.radius,
    required this.color,
    required this.secondColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final mainPaint = Paint()..color = color;
    final smallCirclePaint = Paint()..color = secondColor;

    canvas.drawCircle(Offset(0, size.height / 2), radius, mainPaint);
    canvas.drawCircle(Offset(0, size.height / 2), radius - radius / 2.5, smallCirclePaint);

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = radius / 2.5;
    final p1 = Offset(radius, size.height / 2);
    final p2 = Offset(size.width, size.height / 2);
    canvas.drawLine(p1, p2, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

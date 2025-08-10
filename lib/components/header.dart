import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:task/theme/colors.dart';
import 'package:task/theme/font.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  final double width, height;
  bool showFilter;
  bool isResult;
  bool isScore;
  String score;
  Header({
    super.key,
    required this.width,
    required this.height,
    this.showFilter = false,
    this.isResult = false,
    this.isScore = false,
    this.score = '100',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Stack(
          children: [
            // up left
            Positioned(
              left: -width * 0.3,
              top: -height * 0.035,
              child: circle(width * 0.5),
            ),
            // up center
            Positioned(
              top: -height * 0.07,
              left: width * 0.3,
              child: circle(width * 0.3),
            ),
            // little full circle
            Positioned(
              top: height * 0.03,
              right: width * 0.25,
              child: circle(width * 0.12),
            ),
            // right
            Positioned(
              right: -width * 0.32,
              top: height * 0.085,
              child: circle(width * 0.5),
            ),
            if (showFilter)
              Positioned(
                top: height * 0.03,
                right: width * 0.025,
                child: Image.asset(
                  'assets/icons/filter.png',
                  width: width * 0.07,
                  color: Colors.white70,
                ),
              ),
            if (isResult)
              Positioned(
                top: height * 0.03,
                right: width * 0.025,
                child: Icon(
                  Icons.person,
                  color: Colors.white70,
                  size: width * 0.1,
                ),
              ),
            if (isScore)
              Positioned(
                top: height * 0.25,
                right: 0,
                left: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                          height: height * 0.4,
                          width: height * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                        )
                        .animate(
                          delay: 600.ms,
                          onPlay: (controller) => controller.repeat(
                            reverse: true,
                          ), // تکرار رفت و برگشت
                        )
                        .scaleXY(
                          begin: 1.0,
                          end: 1.15,
                          duration: 1200.ms,
                          curve: Curves.easeInOut,
                        )
                        .fade(
                          begin: 0.2,
                          end: 0.6,
                          duration: 1200.ms,
                          curve: Curves.easeInOut,
                        ),
                    Container(
                          height: height * 0.55,
                          width: height * 0.55,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        )
                        .animate(
                          onPlay: (controller) => controller.repeat(
                            reverse: true,
                          ), // تکرار رفت و برگشت
                        )
                        .scaleXY(
                          begin: 1.0,
                          end: 1.15,
                          duration: 1000.ms,
                          curve: Curves.easeInOut,
                        )
                        .fade(
                          begin: 0.2,
                          end: 0.6,
                          duration: 1000.ms,
                          curve: Curves.easeInOut,
                        ),

                    // دایره اصلی با امتیاز
                    Container(
                      height: height * 0.35,
                      width: height * 0.35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Your Score', style: Fonts.lableMedium()),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: score,
                                  style: Fonts.titleLarge().copyWith(
                                    color: Colors.indigo,
                                  ),
                                ),
                                TextSpan(
                                  text: 'pt',
                                  style: Fonts.lableMedium(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (isResult)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: height * 0.6, // ارتفاع مناسب به لیدربورد بده
                child: LeaderboardShape(width: width, height: height * 0.6),
              ),
          ],
        ),
      ),
    );
  }

  Widget circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.onBlueColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class LeaderboardShape extends StatelessWidget {
  final double width;
  final double height;

  const LeaderboardShape({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final double centerBarWidth = 80;
    final double sideBarWidth = 60;
    final double spaceBetween = 8.0;

    final double height1 = height * 0.9;
    final double height2 = height * 0.6;
    final double height3 = height * 0.4;

    return SizedBox(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          _BarItemWithTrapezoid(
            number: '2',
            score: '442pt',
            height: height2,
            color: const Color(0xFFb39ddb),
            isLeftTrapezoid: true,
            width: sideBarWidth,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: _BarItem(
              number: '1',
              score: '453pt',
              height: height1,
              color: const Color(0xFFb39ddb),
              isCenter: true,
              width: centerBarWidth,
            ),
          ),
          _BarItemWithTrapezoid(
            number: '3',
            score: '373pt',
            height: height3,
            color: const Color(0xFFb39ddb),
            isLeftTrapezoid: false,
            width: sideBarWidth,
          ),
        ],
      ),
    );
  }
}

class _BarItem extends StatelessWidget {
  final String number;
  final String score;
  final double height;
  final Color color;
  final bool isCenter;
  final double width;

  const _BarItem({
    required this.number,
    required this.score,
    required this.height,
    required this.color,
    this.isCenter = false,
    this.width = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isCenter ? 20 : 10),
          bottom: const Radius.circular(0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // اضافه کردن SizedBox برای فاصله دادن عدد از پایین (بر اساس مقدار دلخواه)
          Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontSize: isCenter ? 62 : 24, // بزرگ‌تر کردن فونت عدد مرکز
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            score,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isCenter ? 16 : 12, // بزرگ‌تر کردن فونت امتیاز مرکز
            ),
          ),
          const SizedBox(height: 130),
        ],
      ),
    );
  }
}

class _BarItemWithTrapezoid extends StatelessWidget {
  final String number;
  final String score;
  final double height;
  final Color color;
  final bool isLeftTrapezoid;
  final double width;

  const _BarItemWithTrapezoid({
    required this.number,
    required this.score,
    required this.height,
    required this.color,
    this.isLeftTrapezoid = true,
    this.width = 60,
  });

  @override
  Widget build(BuildContext context) {
    const double trapezoidHeight = 50;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Stack برای اینکه عدد روی مورب باشه
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(width, trapezoidHeight),
              painter: _TrapezoidPainter(color: color, isLeft: isLeftTrapezoid),
            ),
            // عدد روی مورب با فونت بزرگ و سفید
            Positioned(
              top: 10,
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        Container(
          width: width,
          height: height - trapezoidHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(0),
              bottom: Radius.circular(0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // فقط امتیاز زیر عدد، بدون شماره اینجا
              Text(
                score,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrapezoidPainter extends CustomPainter {
  final Color color;
  final bool isLeft;

  _TrapezoidPainter({required this.color, this.isLeft = true});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();

    if (isLeft) {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width * 0.6, 0); // از 0.8 به 0.6 تغییر بده
      path.lineTo(0, 0);
    } else {
      path.moveTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(size.width * 0.4, 0); // از 0.2 به 0.4 تغییر بده
      path.lineTo(size.width, 0);
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:task/theme/colors.dart';
import 'package:task/theme/font.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  final double width, height;
  bool showFilter;
  bool isScore;
  String score;
  Header({
    super.key,
    required this.width,
    required this.height,
    this.showFilter = true,
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

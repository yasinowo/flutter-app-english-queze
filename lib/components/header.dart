import 'package:flutter/material.dart';
import 'package:task/theme/colors.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  final double width, height;
  bool showFilter;
  Header({
    super.key,
    required this.width,
    required this.height,
    this.showFilter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.3,
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

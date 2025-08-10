import 'package:flutter/material.dart';
import 'package:task/components/header.dart';
import 'package:task/theme/colors.dart';
import 'package:task/theme/font.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  const ResultScreen({super.key, this.score = 100, this.totalQuestions = 20});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: width * 0.8,
        height: height * 0.06,
        child: ElevatedButton(
          onPressed: () async {
            await Future.delayed(const Duration(seconds: 3));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 6,
            shadowColor: AppColors.blueColor.withValues(alpha: 0.6),
          ),
          child: Text(
            'What My Rank?',
            style: Fonts.lableMedium().copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Header(
                width: width,
                height: height * 0.5,
                isScore: true,
                // score: '100',
              ),
              Positioned(
                top: height * 0.41,
                left: 0,
                right: 0,
                child: mainResult(width, height),
              ),
              Positioned(
                top: height * 0.66,
                left: 0,
                right: 0,
                child: ActionsGrid(width: width, onTapAction: (index) {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding mainResult(double width, double height) {
    final wrong = totalQuestions - score;
    final percent = ((score / totalQuestions) * 100).round();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Container(
        height: height * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueColor.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: height * 0.05,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  colorCircleWithTexts(
                    circleColor: AppColors.blueColor,
                    topText: '$percent%',
                    bottomText: 'Completation',
                  ),
                  colorCircleWithTexts(
                    circleColor: AppColors.blueColor,
                    topText: '$totalQuestions',
                    bottomText: 'Total Questions',
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  colorCircleWithTexts(
                    circleColor: Colors.green,
                    topText: '$score',
                    bottomText: 'Correct',
                  ),
                  colorCircleWithTexts(
                    circleColor: Colors.red,
                    topText: wrong.toString(),
                    bottomText: 'Wrong               ',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget colorCircleWithTexts({
  required Color circleColor,
  required String topText,
  required String bottomText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          CircleAvatar(radius: 6, backgroundColor: circleColor),
          const SizedBox(width: 5),
          Text(
            topText,
            style: Fonts.lableMedium().copyWith(color: circleColor),
          ),
        ],
      ),
      Text(
        bottomText,
        style: Fonts.bodySmall().copyWith(
          color: Colors.black.withValues(alpha: 0.75),
        ),
      ),
    ],
  );
}

class ActionsGrid extends StatelessWidget {
  final void Function(int) onTapAction;
  final double? width;

  const ActionsGrid({super.key, required this.onTapAction, this.width});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': Icons.replay, 'label': 'Play Again'},
      {'icon': Icons.list_alt, 'label': 'Review Answer'},
      {'icon': Icons.share, 'label': 'Share Score'},
      {'icon': Icons.picture_as_pdf, 'label': 'Generate PDF'},
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.leaderboard, 'label': 'Leader Board'},
    ];

    return SizedBox(
      width: width ?? double.infinity,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: actions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 0,
          crossAxisSpacing: 16,
          childAspectRatio: 1.3,
        ),
        itemBuilder: (context, index) {
          final action = actions[index];
          return GestureDetector(
            onTap: () => onTapAction(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  action['icon'] as IconData,
                  size: 32,
                  color: AppColors.blueColor,
                ),
                const SizedBox(height: 4),
                Text(
                  action['label'] as String,
                  textAlign: TextAlign.center,
                  style: Fonts.bodySmall(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task/screens/result_screen.dart';
import 'package:task/theme/colors.dart';
import 'package:task/components/circle_progras.dart';
import 'package:task/components/header.dart';
import 'package:task/theme/font.dart';
import 'package:task/models/data.dart';
import 'package:task/models/question_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<QuestionModel> questions;
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  bool showAnswer = false;
  bool isAnswerCorrect = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    questions = questionsJson.map((e) => QuestionModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: width * 0.8,
        height: height * 0.06,
        child: ElevatedButton(
          onPressed: (selectedOptionIndex == null || showAnswer)
              ? null
              : () async {
                  setState(() {
                    showAnswer = true;
                    isAnswerCorrect =
                        selectedOptionIndex == currentQuestion.correctAnswer;

                    if (isAnswerCorrect) {
                      score++; // افزایش امتیاز در صورت پاسخ درست
                    }
                  });

                  await Future.delayed(const Duration(seconds: 3));

                  setState(() {
                    showAnswer = false;
                    selectedOptionIndex = null;

                    if (currentQuestionIndex < questions.length - 1) {
                      currentQuestionIndex++;
                    } else {
                      // پایان تست
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            score: score,
                            totalQuestions: questions.length,
                          ),
                        ),
                      );
                    }
                  });
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedOptionIndex != null
                ? AppColors.blueColor
                : AppColors.disibaleColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 6,
            shadowColor: AppColors.blueColor.withValues(alpha: 0.6),
          ),
          child: Text(
            currentQuestionIndex < questions.length - 1 ? 'Next' : 'Finish',
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
              Header(width: width, height: height * 0.3, showFilter: true),
              question(height, width, currentQuestion, currentQuestionIndex),
              option(height, width, currentQuestion),
            ],
          ),
        ),
      ),
    );
  }

  Positioned question(
    double height,
    double width,
    QuestionModel question,
    int index,
  ) {
    final progress = 0.2 + 0.8 * (index / (questions.length - 1));

    return Positioned(
      top: height * 0.2,
      left: 0,
      right: 0,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Container(
              height: height * 0.23,
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
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.02),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Fonts.lableMedium(),
                        children: [
                          const TextSpan(text: 'Question '),
                          TextSpan(
                            text: '${index + 1}',
                            style: Fonts.lableMedium().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          TextSpan(text: ' /${questions.length}'),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.02),
                    Text(
                      textAlign: TextAlign.center,
                      question.question,
                      style: Fonts.bodyMedium(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -height * 0.035,
            child: SizedBox(
              height: height * 0.07,
              width: width * 0.15,
              child: CircularProgressRing(
                progress: progress,
                number: index + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned option(double height, double width, QuestionModel question) {
    return Positioned(
      top: height * 0.46,
      left: width * 0.05,
      right: width * 0.05,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(question.options.length, (index) {
          final option = question.options[index];
          final bool isSelected = selectedOptionIndex == index;
          final bool isCorrect = question.correctAnswer == index;

          return GestureDetector(
            onTap: showAnswer
                ? null
                : () {
                    setState(() {
                      selectedOptionIndex = index;
                    });
                  },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: showAnswer
                    ? (isCorrect
                          ? Colors.green.withValues(alpha: 0.2)
                          : (isSelected
                                ? Colors.red.withValues(alpha: 0.2)
                                : Colors.transparent))
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: showAnswer
                      ? (isCorrect
                            ? Colors.green
                            : (isSelected ? Colors.red : Colors.grey.shade300))
                      : (isSelected
                            ? AppColors.blueColor
                            : Colors.grey.shade300),
                  width: isSelected || isCorrect ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option,
                      style: Fonts.bodyMedium().copyWith(
                        color: showAnswer
                            ? (isCorrect
                                  ? Colors.green[700]
                                  : (isSelected ? Colors.red : Colors.black87))
                            : (isSelected
                                  ? AppColors.blueColor
                                  : Colors.black87),
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: showAnswer
                            ? (isCorrect
                                  ? Colors.green
                                  : (isSelected
                                        ? Colors.red
                                        : Colors.grey.shade400))
                            : (isSelected
                                  ? AppColors.blueColor
                                  : Colors.grey.shade400),
                        width: 2,
                      ),
                      color: showAnswer
                          ? (isCorrect
                                ? Colors.green
                                : (isSelected
                                      ? Colors.red
                                      : Colors.transparent))
                          : (isSelected
                                ? AppColors.blueColor
                                : Colors.transparent),
                    ),
                    child: showAnswer
                        ? (isCorrect
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : (isSelected
                                    ? const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : null))
                        : (isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : null),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task/components/header.dart';
import 'package:task/theme/colors.dart';
import 'package:task/theme/font.dart';

class RankScreen extends StatelessWidget {
  final int score;
  const RankScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Header(width: width, height: height * 0.52, isResult: true),
              Positioned(
                top: height * 0.5,
                left: 0,
                right: 0,
                child: main(width, height),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container main(double width, double height) {
    // داده اولیه بدون شما
    List<Map<String, dynamic>> fakeData = [
      {'name': 'Alice', 'score': 453},
      {'name': 'Bob', 'score': 442},
      {'name': 'Charlie', 'score': 373},
      {'name': 'David', 'score': 320},
      {'name': 'Eve', 'score': 290},
    ];

    // اضافه کردن خودتان با امتیاز ورودی صفحه
    fakeData.add({'name': 'You', 'score': score});

    // مرتب سازی نزولی بر اساس امتیاز
    fakeData.sort((a, b) => b['score'].compareTo(a['score']));

    return Container(
      height: height,
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
        padding: EdgeInsets.symmetric(vertical: 24),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: fakeData.length,
          itemBuilder: (context, index) {
            final item = fakeData[index];
            final isYou = item['name'] == 'You';
            final rank = index + 1; // شماره رتبه بر اساس ایندکس لیست

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isYou
                    ? AppColors.blueColor.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // شماره رتبه
                  Text(
                    '$rank',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isYou ? AppColors.blueColor : Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // آیکون person
                  Icon(
                    Icons.person,
                    color: isYou ? AppColors.blueColor : Colors.grey,
                    size: 28,
                  ),
                  const SizedBox(width: 16),

                  // نام
                  Expanded(
                    child: Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isYou ? FontWeight.bold : FontWeight.normal,
                        color: isYou ? AppColors.blueColor : Colors.black87,
                      ),
                    ),
                  ),

                  // باکس امتیاز گوشه‌گرد
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isYou
                          ? AppColors.blueColor
                          : AppColors.blueColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${item['score']} pt',
                      style: TextStyle(
                        color: isYou ? Colors.white : AppColors.blueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

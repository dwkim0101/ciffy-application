import 'package:ciffy_application/widgets/graduation_analysis/grad_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터
    const totalCredits = 140;
    const completedCredits = 94;
    const percent = 0.67;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: GradColors.cardBg,
        borderRadius: BorderRadius.circular(GradColors.cardRadius),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 32, 0, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('전체',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: GradColors.primary,
                      )),
                  SizedBox(height: 12),
                  Text('140',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        color: GradColors.subText,
                      )),
                  Text('총 기준 학점',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: GradColors.primary,
                      )),
                  SizedBox(height: 8),
                  Text('94',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        color: GradColors.point,
                      )),
                  Text('총 이수 학점',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: GradColors.primary,
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 24, 24, 24),
            child: SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: percent,
                      strokeWidth: 10,
                      backgroundColor: GradColors.progressBg,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(GradColors.point),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('전체',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: GradColors.primary,
                          )),
                      SizedBox(height: 4),
                      Text('67%',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: GradColors.primary,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

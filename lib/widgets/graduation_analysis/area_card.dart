import 'package:flutter/material.dart';
import 'grad_colors.dart';

class AreaCard extends StatelessWidget {
  final String title;
  final VoidCallback? onDetail;
  final List<Widget> children;
  const AreaCard({
    super.key,
    required this.title,
    this.onDetail,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: GradColors.cardBg,
        borderRadius: BorderRadius.circular(GradColors.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: GradColors.primary,
                ),
              ),
              if (onDetail != null)
                GestureDetector(
                  onTap: onDetail,
                  child: const Row(
                    children: [
                      Text(
                        '자세히보기',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: GradColors.subText,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(Icons.chevron_right,
                          size: 18, color: GradColors.subText),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

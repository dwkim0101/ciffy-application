import 'package:flutter/material.dart';
import 'grad_colors.dart';

class AreaItemBar extends StatelessWidget {
  final String label;
  final int current;
  final int total;
  final Color? color;
  const AreaItemBar({
    super.key,
    required this.label,
    required this.current,
    required this.total,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0.0 : current / total;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: GradColors.primary,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: GradColors.progressBg,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percent,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: color ?? GradColors.progressMain,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '$current / $total',
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: GradColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

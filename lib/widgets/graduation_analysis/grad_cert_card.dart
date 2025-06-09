import 'package:flutter/material.dart';
import 'grad_colors.dart';

class GradCertCard extends StatelessWidget {
  final int passed;
  final int total;
  final List<GradCertItem> certs;
  final VoidCallback? onDetail;
  final String? guideText;
  const GradCertCard({
    super.key,
    required this.passed,
    required this.total,
    required this.certs,
    this.onDetail,
    this.guideText,
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
                '졸업인증  $passed / $total',
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
          if (guideText != null) ...[
            const SizedBox(height: 4),
            Text(
              guideText!,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: GradColors.subText,
              ),
            ),
          ],
          const SizedBox(height: 16),
          ...certs.map((c) => _GradCertItemRow(item: c)),
        ],
      ),
    );
  }
}

class GradCertItem {
  final String name;
  final bool passed;
  final double percent;
  GradCertItem(
      {required this.name, required this.passed, required this.percent});
}

class _GradCertItemRow extends StatelessWidget {
  final GradCertItem item;
  const _GradCertItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              item.name,
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: GradColors.primary,
              ),
            ),
          ),
          Container(
            width: 24,
            alignment: Alignment.center,
            child: Text(
              item.passed ? 'P' : 'NP',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: item.passed ? GradColors.pass : GradColors.notPass,
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
                  widthFactor: item.percent,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: item.percent == 1.0
                          ? GradColors.progressMain
                          : GradColors.progressSub,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

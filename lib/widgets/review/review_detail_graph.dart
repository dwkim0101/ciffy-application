import 'package:flutter/material.dart';

class ReviewDetailGraph extends StatelessWidget {
  const ReviewDetailGraph({super.key});

  @override
  Widget build(BuildContext context) {
    // Figma 기준 더미 데이터
    final starDist = [
      {'score': 5, 'percent': 68},
      {'score': 4, 'percent': 23},
      {'score': 3, 'percent': 4},
      {'score': 2, 'percent': 2},
      {'score': 1, 'percent': 2},
    ];
    final categories = [
      {
        'title': '과제',
        'labels': ['없음', '보통', '많음'],
        'values': [4, 83, 13],
        'colors': [
          const Color(0xFF8886A3),
          const Color(0xFF06003A),
          const Color(0xFF8886A3)
        ],
      },
      {
        'title': '조모임',
        'labels': ['없음', '보통', '많음'],
        'values': [100, 0, 0],
        'colors': [
          const Color(0xFF06003A),
          const Color(0xFF8886A3),
          const Color(0xFF8886A3)
        ],
      },
      {
        'title': '성적',
        'labels': ['너그러움', '보통', '깐깐함'],
        'values': [55, 34, 11],
        'colors': [
          const Color(0xFF06003A),
          const Color(0xFF8886A3),
          const Color(0xFF8886A3)
        ],
      },
    ];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        border: Border.all(color: const Color(0xFFF1F2F8), width: 1),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 평점/별점/평가수 한 줄
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '4.53',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0xFF06003A),
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: List.generate(
                      5,
                      (i) => Icon(
                            Icons.star,
                            color: i < 4
                                ? const Color(0xFFFFBF00)
                                : const Color(0xFFE6E6E6),
                            size: 22,
                          )),
                ),
                const SizedBox(width: 8),
                const Text(
                  '(47개의 평가)',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Color.fromRGBO(6, 0, 58, 0.3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // 별점 분포
            ...starDist.map(
                (e) => _StarBar(score: e['score']!, percent: e['percent']!)),
            const SizedBox(height: 18),
            // 구분선
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 1,
              color: const Color(0xFFF1F2F8),
            ),
            // 카테고리별 비율
            ...categories.map((cat) => _CategoryBar(
                  title: cat['title'] as String,
                  labels: List<String>.from(cat['labels'] as List),
                  values: List<int>.from(cat['values'] as List),
                  colors: List<Color>.from(cat['colors'] as List),
                )),
          ],
        ),
      ),
    );
  }
}

class _StarBar extends StatelessWidget {
  final int score;
  final int percent;
  const _StarBar({required this.score, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.star, color: Color(0xFFFFBF00), size: 18),
          const SizedBox(width: 2),
          Text('$score',
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF06003A),
              )),
          const SizedBox(width: 8),
          Text(
            '$percent%',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: percent > 0
                  ? const Color(0xFFFFBF00)
                  : const Color(0xFFE6E6E6),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F2F8),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percent / 100,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFBF00),
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

class _CategoryBar extends StatelessWidget {
  final String title;
  final List<String> labels;
  final List<int> values;
  final List<Color> colors;
  const _CategoryBar(
      {required this.title,
      required this.labels,
      required this.values,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    final total = values.fold<int>(0, (a, b) => a + b);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF06003A),
            ),
          ),
          const SizedBox(height: 8),
          ...List.generate(labels.length, (i) {
            final percent = total == 0 ? 0 : (values[i] / total * 100).round();
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    child: Text(
                      labels[i],
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: colors[i],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 36,
                    child: Text(
                      '$percent%',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: colors[i],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F2F8),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: percent / 100,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: colors[i],
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
          }),
        ],
      ),
    );
  }
}

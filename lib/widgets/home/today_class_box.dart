import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TodayClassBox extends StatelessWidget {
  const TodayClassBox({super.key});

  @override
  Widget build(BuildContext context) {
    // 임시 수업 데이터
    final todayClasses = [
      '스마트UX&UI디자인1',
      '인포그래픽',
      '그래픽디자인1',
    ];
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 140),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0740),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // 수업 리스트 (왼쪽 상단, 오른쪽 패딩 넉넉히)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 90, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ...todayClasses.map((c) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: const BoxDecoration(
                              color: Color(0xFF5A7BFF),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              c,
                              style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white,
                                height: 1.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          // 일러스트 (오른쪽 하단, 모바일 크기)
          Positioned(
            right: 0,
            bottom: -20,
            child: SvgPicture.asset(
              'assets/block_character.svg',
              width: 110,
              height: 110,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/graduation_analysis_screen.dart';
import '../screens/timetable_screen.dart';
import '../screens/review_screen.dart';
import '../screens/mypage_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _tabs = [
    {'label': '졸업요건분석', 'icon': 'assets/bottom_bar/graduate.svg'},
    {'label': '시간표짜기', 'icon': 'assets/bottom_bar/timetable.svg'},
    {'label': '강의후기', 'icon': 'assets/bottom_bar/review.svg'},
    {'label': '마이페이지', 'icon': 'assets/bottom_bar/mypage.svg'},
  ];

  // 각 탭에 해당하는 화면 위젯 리스트 (실제 화면 위젯으로 교체 필요)
  final List<Widget> _pages = [
    const GraduationAnalysisScreen(),
    const TimeTableScreen(),
    const ReviewScreen(),
    const MyPageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
            border: const Border(
              top: BorderSide(color: Colors.white, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_tabs.length, (index) {
              final tab = _tabs[index];
              final isSelected = index == _selectedIndex;
              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => _onItemTapped(index),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          tab['icon']!,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            isSelected
                                ? const Color(0xFF06003A)
                                : const Color(0xFF888696),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          tab['label']!,
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                            fontSize: 12,
                            color: isSelected
                                ? const Color(0xFF06003A)
                                : const Color(0xFF888696),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

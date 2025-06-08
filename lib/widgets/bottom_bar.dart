import 'package:ciffy_application/screens/home_screen.dart';
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
    {'label': '홈', 'icon': 'assets/bottom_bar/home.svg'},
    {'label': '시간표짜기', 'icon': 'assets/bottom_bar/timetable.svg'},
    {'label': '졸업요건분석', 'icon': 'assets/bottom_bar/graduate.svg'},
    {'label': '마이페이지', 'icon': 'assets/bottom_bar/mypage.svg'},
  ];

  // 각 탭에 해당하는 화면 위젯 리스트 (실제 화면 위젯으로 교체 필요)
  final List<Widget> _pages = [
    const HomeScreen(),
    const TimeTableScreen(),
    const GraduationAnalysisScreen(),
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
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.white,
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_tabs.length, (index) {
              final tab = _tabs[index];
              final isSelected = index == _selectedIndex;
              return Expanded(
                child: InkWell(
                  onTap: () => _onItemTapped(index),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      height: 44,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            tab['icon']!,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? const Color(0xFF06003A)
                                  : const Color(0xFF888696),
                              BlendMode.srcIn,
                            ),
                          ),
                          const Spacer(),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              tab['label']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                fontSize: 12,
                                color: isSelected
                                    ? const Color(0xFF06003A)
                                    : const Color(0xFF888696),
                              ),
                            ),
                          ),
                        ],
                      ),
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

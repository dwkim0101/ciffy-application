import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _tabs = [
    {'label': '시간표짜기', 'icon': 'assets/bottom_bar/timetable.svg'},
    {'label': '강의후기', 'icon': 'assets/bottom_bar/review.svg'},
    {'label': '졸업요건분석', 'icon': 'assets/bottom_bar/graduate.svg'},
    {'label': '마이', 'icon': 'assets/bottom_bar/mypage.svg'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // TODO: Add navigation logic for each tab
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: _tabs.map((tab) {
        final isSelected = _tabs.indexOf(tab) == _selectedIndex;
        return BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                tab['icon']!,
                width: 24,
                height: 24,
                color: isSelected
                    ? const Color(0xFF06003A)
                    : const Color(0xFF888696),
              ),
              const SizedBox(height: 4), // 아이콘과 글씨 사이의 간격 조정
            ],
          ),
          label: tab['label'],
        );
      }).toList(),
      selectedItemColor: const Color(0xFF06003A),
      unselectedItemColor: const Color(0xFF888696),
      selectedLabelStyle: const TextStyle(
        fontSize: 12, // 선택된 탭도 동일한 폰트 크기 유지
        fontWeight: FontWeight.w600,
        fontFamily: 'Pretendard',
        color: Color(0xFF06003A),
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12, // 비활성화된 탭과 동일한 폰트 크기 유지
        fontWeight: FontWeight.w400,
        fontFamily: 'Pretendard',
        color: Color(0xFF888696),
      ),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed, // 동그라미 애니메이션 제거
      selectedFontSize: 12, // 선택된 탭의 폰트 크기 고정
      unselectedFontSize: 12, // 비활성화된 탭의 폰트 크기 고정
      iconSize: 20, // 아이콘 크기 조정
      selectedIconTheme: const IconThemeData(size: 20), // 선택된 아이콘 크기 고정
      unselectedIconTheme: const IconThemeData(size: 20), // 비활성화된 아이콘 크기 고정
    );
  }
}

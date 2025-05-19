import 'package:flutter/material.dart';
import '../widgets/bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('졸업요건분석'),
      ),
      body: const Center(
        child: Text(
          '졸업요건분석 화면 Placeholder',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';
import 'screen4.dart';

void main() => runApp(const MainApp());

class TabModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void selectTab(int index) {
    if (index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TabModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavLab(),
      ),
    );
  }
}

class BottomNavLab extends StatelessWidget {
  const BottomNavLab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Part 1: Lab A'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const _TabBody(),
      bottomNavigationBar: const _TabBar(),
    );
  }
}

class _TabBody extends StatelessWidget {
  const _TabBody();

  static const List<Widget> _screens = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<TabModel>().currentIndex;
    return _screens[currentIndex];
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<TabModel>().currentIndex;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.white,
      backgroundColor: Colors.blue,
      iconSize: 30,
      currentIndex: currentIndex,
      onTap: (int index) => context.read<TabModel>().selectTab(index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Alarm'),
        BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
      ],
    );
  }
}

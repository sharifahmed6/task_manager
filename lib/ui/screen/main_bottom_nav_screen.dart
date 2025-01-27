import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/ui/screen/cancelled_task_list_screen.dart';
import 'package:task_manager/ui/screen/complete_task_list_screen.dart';
import 'package:task_manager/ui/screen/new_task_list_screen.dart';
import 'package:task_manager/ui/screen/progress_task_list_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static const String name = 'home';
  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screen = const [
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    CompleteTaskListScreen(),
    CancelledTaskListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            _selectedIndex = index;
            setState(() {});
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.new_label_outlined), label: 'New'),
            NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Complete'),
            NavigationDestination(
                icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
          ]),
    );
  }
}

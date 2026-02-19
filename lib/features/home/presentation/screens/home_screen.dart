import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idle_laboratory/features/home/presentation/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Widget _buildContent() {
    switch (_selectedTabIndex) {
      case 0:
        return const SizedBox.shrink(); // Laboratory - empty for now
      case 1:
        return const SizedBox.shrink(); // Chemicals - empty for now
      case 2:
        return const SettingsToggle(); // Settings
      case 3:
        return const SizedBox.shrink(); // Statistics - empty for now
      case 4:
        return const SizedBox.shrink(); // Achievements - empty for now
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Left navigation drawer with energy display inside
              NavigationDrawerWidget(
                selectedIndex: _selectedTabIndex,
                onTabSelected: _onTabSelected,
              ),
              // Right content area - full width
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }
}

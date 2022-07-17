import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:corporatetransportapp/view/employee/employee_map.dart';
import 'package:corporatetransportapp/view/employee/my_ride.dart';
import 'package:corporatetransportapp/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class EmployeeDashboard extends StatefulWidget {
  final VoidCallback? openDrawer;
  const EmployeeDashboard({Key? key, this.openDrawer}) : super(key: key);

  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard>
    with WidgetsBindingObserver {
  int _pageIndex = 0;
  late PageController _pageController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double angle = pi;

  @override
  void initState() {
        Location.instance.requestPermission();

    _pageController = PageController(
      initialPage: _pageIndex,
      keepPage: false,
    );

    super.initState();
  }

  double? _getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr) {
      return lerpDouble(-1.0, 1.0, index / 2);
    } else {
      return lerpDouble(1.0, -1.0, index / 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        int currentPos = _pageController.page?.round() ?? 0;
        if (currentPos == 0) {
          return true;
        } else {
          onTabTapped(0);
          return false;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: SizedBox(
          height: 58,
          child: Stack(
            children: [
              BottomNavigationBar(
                  onTap: onTabTapped,
                  unselectedIconTheme: const IconThemeData(
                    color: Colors.black,
                  ),
                  selectedIconTheme: const IconThemeData(
                    color: Color(0xFF107189),
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                  ),
                  selectedLabelStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black,
                  showUnselectedLabels: true,
                  currentIndex: _pageIndex,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Profile",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map),
                      label: "Map",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.time_to_leave),
                      label: "My Ride",
                    )
                  ]),
              Positioned(
                top: 0,
                width: width,
                child: AnimatedAlign(
                  alignment: Alignment(_getIndicatorPosition(_pageIndex)!, 0),
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    color: const Color(0xFF107189),
                    width: width / 3,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: PageView(
            onPageChanged: onPageChanged,
            controller: _pageController,
            allowImplicitScrolling: false,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ProfileScreen(
                openDrawer: openDrawer,
              ),
              const EmployeeMap(),
              const MyRide(),
            ],
          ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) async {
    _pageController.jumpToPage(
      index,
      
    );
  }

  void appointmentCardClickHandle() {
    onTabTapped(2);
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void openDrawer() {
    widget.openDrawer!();
  }
}

import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/view/admin/driver_list.dart';
import 'package:corporatetransportapp/view/admin/employee_list.dart';
import 'package:corporatetransportapp/view/admin/map_screen.dart';
import 'package:corporatetransportapp/view/admin/vehicles_list.dart';
import 'package:corporatetransportapp/view/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  final VoidCallback? openDrawer;
  const AdminDashboard({Key? key, this.openDrawer}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with WidgetsBindingObserver {
  int _pageIndex = 0;
  late PageController _pageController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double angle = pi;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _pageIndex,
      keepPage: false,
    );
    Location.instance.requestPermission();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      dataController.fetchProfile(
          userid: dataController.user.userid ?? '',
          role: dataController.user.role ?? '');
      dataController.getDrivers();
      dataController.getEmployees();
      dataController.getVehicles();
    });

    super.initState();
  }

  double? _getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr) {
      return lerpDouble(-1.0, 1.0, index / 4);
    } else {
      return lerpDouble(1.0, -1.0, index / 4);
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
                      icon: Icon(CupertinoIcons.person_3_fill),
                      label: "Driver",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map),
                      label: "Map",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person_crop_square_fill),
                      label: "Employee",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.time_to_leave),
                      label: "Vehicle",
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
                    width: width / 5,
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
              const DriverList(),
              const MapScreen(),
              const EmployeeList(),
              const VehiclesList(),
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
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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

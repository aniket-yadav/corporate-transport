import 'package:corporatetransportapp/menu/employee_menu_screen.dart';
import 'package:corporatetransportapp/view/employee/employee_dashboard.dart';
import 'package:flutter/material.dart';

class EmployeeMainScreen extends StatefulWidget {
  const EmployeeMainScreen({Key? key}) : super(key: key);

  static const routeName = "/employeeMainScreen";
  @override
  State<EmployeeMainScreen> createState() => _EmployeeMainScreenState();
}

class _EmployeeMainScreenState extends State<EmployeeMainScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      closeDrawer();
    });
  }

  void openDrawer() {
    setState(() {
      xOffset = MediaQuery.of(context).size.width * 0.85;
      yOffset = MediaQuery.of(context).size.height * 0.10;
      scaleFactor = 0.8;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: Material(
        child: Stack(
          children: [
            buildDrawer(),
            buildDashboard(),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return GestureDetector(
      onHorizontalDragStart: (details) => isDragging = true,
      onHorizontalDragUpdate: (details) {
        if (!isDragging) return;
        const delta = 1;
        if (details.delta.dx < -delta) {
          closeDrawer();
        }
        isDragging = false;
      },
      child: EmployeeMenuScreen(
        closeDrawer: closeDrawer,
      ),
    );
  }

  Widget buildDashboard() {
    return GestureDetector(
      onTap: closeDrawer,
      onHorizontalDragStart: (details) => isDragging = true,
      onHorizontalDragUpdate: (details) {
        if (!isDragging) return;
        const delta = 1;
        if (details.delta.dx < -delta) {
          closeDrawer();
        }
        isDragging = false;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        child: AbsorbPointer(
          absorbing: isDrawerOpen,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe6e6e6),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: Offset(
                    -10,
                    20,
                  ),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: EmployeeDashboard(openDrawer: openDrawer),
            ),
          ),
        ),
      ),
    );
  }
}

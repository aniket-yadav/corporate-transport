import 'package:corporatetransportapp/enum/roles.dart';
import 'package:corporatetransportapp/utils/global_variable.dart';
import 'package:corporatetransportapp/utils/session_manager.dart';
import 'package:corporatetransportapp/view/admin/admin_main_screen.dart';
import 'package:corporatetransportapp/view/driver/driver_main_screen.dart';
import 'package:corporatetransportapp/view/employee/employee_main_screen.dart';
import 'package:corporatetransportapp/view/login.dart';
import 'package:flutter/material.dart';
import 'package:corporatetransportapp/assets/images.dart' as icons;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      checkLogin();
    });
    super.initState();
  }

  checkLogin() async {
    bool hasUser = await SessionManager.hasUser();
    String role = await SessionManager.getRole();

    if (hasUser) {
      if (role == Role.admin.name) {
        Navigator.of(GlobalVariable.navState.currentContext!)
            .pushReplacementNamed(AdminMainScreen.routeName);
      } else if (role == Role.rider.name) {
        Navigator.of(GlobalVariable.navState.currentContext!)
            .pushReplacementNamed(EmployeeMainScreen.routeName);
      } else if (role == Role.driver.name) {
        Navigator.of(GlobalVariable.navState.currentContext!)
            .pushReplacementNamed(DriverMainScreen.routeName);
      }
    } else {
      Navigator.of(GlobalVariable.navState.currentContext!)
          .pushReplacementNamed(Login.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF104271),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage(icons.corporateTransport),
            ),
          ],
        ),
      ),
    );
  }
}

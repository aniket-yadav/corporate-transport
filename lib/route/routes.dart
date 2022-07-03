import 'package:corporatetransportapp/view/admin/add_driver.dart';
import 'package:corporatetransportapp/view/admin/add_employee.dart';
import 'package:corporatetransportapp/view/admin/add_vehicle.dart';
import 'package:corporatetransportapp/view/admin/admin_main_screen.dart';
import 'package:corporatetransportapp/view/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (_) => const SplashScreen(),
  AdminMainScreen.routeName: (_) => const AdminMainScreen(),
  AddDriver.routeName: (_) => const AddDriver(),
  AddEmployee.routeName: (_) => const AddEmployee(),
  AddVehicle.routeName: (_) => const AddVehicle(),
};

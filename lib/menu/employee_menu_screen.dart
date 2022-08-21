import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/menu/menu_header.dart';
import 'package:corporatetransportapp/utils/session_manager.dart';
import 'package:corporatetransportapp/view/add_feedback.dart';
import 'package:corporatetransportapp/view/change_password.dart';
import 'package:corporatetransportapp/view/employee/chat.dart';
import 'package:corporatetransportapp/view/employee/my_billings.dart';
import 'package:corporatetransportapp/view/login.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class EmployeeMenuScreen extends StatefulWidget {
  final VoidCallback? closeDrawer;
  const EmployeeMenuScreen({Key? key, this.closeDrawer}) : super(key: key);

  @override
  State<EmployeeMenuScreen> createState() => _EmployeeMenuScreenState();
}

class _EmployeeMenuScreenState extends State<EmployeeMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFF2F9FB),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const MenuHeader(),
            const SizedBox(
              height: 8,
            ),
            Divider(
              color: const Color(0xff444444).withOpacity(0.8),
              thickness: 0.2,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  InkWell(
                    onTap: () {
                      widget.closeDrawer!();
                      Navigator.of(context).pushNamed(Chat.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.message,
                            color: Color(0xFF107189),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Chat",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.closeDrawer!();
                      Navigator.of(context).pushNamed(MyBilling.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.payment,
                            color: Color(0xFF107189),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Bills",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.closeDrawer!();
                      Navigator.of(context).pushNamed(ChangePassword.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.security,
                            color: Color(0xFF107189),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.closeDrawer!();
                      Navigator.of(context).pushNamed(AddFeedback.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.feedback,
                            color: Color(0xFF107189),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Feedback",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      widget.closeDrawer!();
                      final dataController =
                          Provider.of<DataController>(context, listen: false);
                      var res = await Location.instance.hasPermission();
                      if (res == PermissionStatus.granted) {
                        var loc = await Location.instance.getLocation();

                        dataController.callSOS(
                            lat: "${loc.latitude ?? ''}",
                            log: "${loc.longitude ?? ''}");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.sos,
                            color: Color(0xFF107189),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "SOS",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      SessionManager.signOut();
                      if (!(await SessionManager.hasUser())) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Login.routeName, (Route<dynamic> route) => false);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.logout,
                            color: Color(0xFF107189),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "logout",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

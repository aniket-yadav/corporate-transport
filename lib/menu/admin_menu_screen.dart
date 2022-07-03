import 'package:corporatetransportapp/menu/menu_header.dart';
import 'package:flutter/material.dart';

class AdminMenuScreen extends StatefulWidget {
  final VoidCallback? closeDrawer;
  const AdminMenuScreen({Key? key, this.closeDrawer}) : super(key: key);

  @override
  State<AdminMenuScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
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
                  Container(
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
                  Container(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

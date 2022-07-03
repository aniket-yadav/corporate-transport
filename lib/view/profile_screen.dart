import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final void Function() openDrawer;

  const ProfileScreen({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                widget.openDrawer();
              },
              icon: const Icon(
                CupertinoIcons.line_horizontal_3_decrease_circle_fill,
                size: 45,
                color: Color(0xFF107189),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

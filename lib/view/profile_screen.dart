import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corporatetransportapp/assets/images.dart' as icons;

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 50.0,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFcfe3e7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: const [
                        Image(
                          image: AssetImage(
                            icons.profilePlaceholder,
                          ),
                          width: 120,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Aniket Yadav",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff191919),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff797979),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                top: 20.0,
                right: 20.0,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFcfe3e7),
                      blurRadius: 2,
                    )
                  ]),
              padding: const EdgeInsets.all(
                10.0,
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.call,
                    color: Color(0xFF107189),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    "o409234723",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
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

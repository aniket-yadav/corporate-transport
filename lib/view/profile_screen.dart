import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/widgets/data_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corporatetransportapp/assets/images.dart' as icons;
import 'package:provider/provider.dart';

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
    final userProvider = Provider.of<DataController>(context);
    print(userProvider.user.toJson());
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
                      children: [
                        const Image(
                          image: AssetImage(
                            icons.profilePlaceholder,
                          ),
                          width: 120,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          userProvider.user.name ?? '',
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff191919),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userProvider.user.role ?? '',
                          style: const TextStyle(
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
            DataTile(
              icon: Icons.call,
              label: userProvider.user.mobile ?? '',
            ),
            DataTile(
              icon: Icons.email,
              label: userProvider.user.email ?? '',
            ),
          ],
        ),
      ),
    );
  }
}

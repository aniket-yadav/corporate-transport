import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/enum/roles.dart';
import 'package:corporatetransportapp/utils/global_variable.dart';
import 'package:corporatetransportapp/view/employee/my_pickup_point.dart';
import 'package:corporatetransportapp/widgets/data_tile.dart';
import 'package:corporatetransportapp/widgets/profile_photo_selection_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corporatetransportapp/assets/images.dart' as icons;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
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
  LatLng? mapLocation;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<DataController>(context);
    print(userProvider.user.latitude);
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
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 42.0,
                                child: (userProvider.user.image != null &&
                                        userProvider.user.image!.isNotEmpty)
                                    ? Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          child: Image.network(
                                            userProvider.user.image!,
                                            height: 80.0,
                                            width: 80.0,
                                          ),
                                        ),
                                      )
                                    : Image.asset(
                                        icons.profilePlaceholder,
                                      ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () async {
                                  var res = await showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: ProfilePhotoSelectionPanel(),
                                    ),
                                  );
                                  if (res == true) {
                                    userProvider.fetchProfile(
                                        role: userProvider.user.role ?? '');
                                  }
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                          ],
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
            if (userProvider.user.role == Role.employee.name)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    var hasPermission = await Location.instance.hasPermission();
                    
                    if (hasPermission == PermissionStatus.granted) {
                      if (userProvider.user.latitude != null &&
                          userProvider.user.longitude != null) {
                        mapLocation = LatLng(
                            double.parse(userProvider.user.latitude ?? '0'),
                            double.parse(userProvider.user.longitude ?? '0'));
                      }
                      var latlng = await Navigator.of(
                              GlobalVariable.navState.currentContext!)
                          .pushNamed(
                        MyPickupPoint.routeName,
                        arguments: mapLocation,
                      );
                      if (latlng != null) {
                        setState(() {
                          mapLocation = latlng as LatLng;
                          print(latlng.latitude);
                          print(latlng.longitude);
                          if (mapLocation != null) {
                            userProvider.updateMyPickup(pickup: mapLocation!);
                          }
                        });
                      }
                    } else {
                      await Location.instance.requestPermission();
                    }
                  },
                  child: Text(userProvider.user.latitude != null &&
                          userProvider.user.longitude != null
                      ? "Change Pick-up Point"
                      : "Add Pick-Up Point"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

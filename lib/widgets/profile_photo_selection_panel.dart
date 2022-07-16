import 'dart:convert';
import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/utils/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePhotoSelectionPanel extends StatelessWidget {
  late final DataController userProvider;

  ProfilePhotoSelectionPanel({Key? key}) : super(key: key) {
    // throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<DataController>(context, listen: false);

    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profile Photo",
                style: TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  spacing: 35.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        removeProfile();
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF107189),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                          const SizedBox(
                            height: 9.0,
                          ),
                          const Text(
                            "Remove Photo",
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        uploadPhoto(ImageSource.camera);
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF107189),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: const Icon(
                              Icons.photo_camera_rounded,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                          const SizedBox(
                            height: 9.0,
                          ),
                          const Text(
                            "Camera",
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        uploadPhoto(ImageSource.gallery);
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF107189),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: const Icon(
                              Icons.camera,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                          const SizedBox(
                            height: 9.0,
                          ),
                          const Text(
                            "Gallery",
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void removeProfile() async {
    var res = await userProvider.uploadPhoto(
        image: null, role: userProvider.user.role ?? '');
    Navigator.of(GlobalVariable.navState.currentContext!).pop(res);
  }

  void uploadPhoto(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo =
          await picker.pickImage(source: source, imageQuality: 50);
      if (photo != null) {
        var thumbnail = base64Encode(await photo.readAsBytes());
        print(thumbnail.length);
        // if (thumbnail.isNotEmpty) {
        //   if (thumbnail.length % 4 > 0) {
        //     thumbnail += '=' * (4 - thumbnail.length % 4);
        //   }

          if (thumbnail.isNotEmpty) {
            var res = await userProvider.uploadPhoto(
              image: thumbnail,
              role: userProvider.user.role ?? '',
            );
            Navigator.of(GlobalVariable.navState.currentContext!).pop(res);
          }
        // }
      }
    } catch (_) {}
  }
}

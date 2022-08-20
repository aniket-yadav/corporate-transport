import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MyPickupPoint extends StatefulWidget {
  const MyPickupPoint({Key? key}) : super(key: key);
  static const routeName = "/myPickupPoint";
  @override
  State<MyPickupPoint> createState() => _MyPickupPointState();
}

class _MyPickupPointState extends State<MyPickupPoint> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? selectedLocation;
  GoogleMapController? controller;
  Set<Marker> markers = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      LatLng? temp = ModalRoute.of(context)?.settings.arguments as LatLng?;

      if (temp != null) {
        print(" temp : $temp");
        var marker = Marker(
          markerId: const MarkerId("pickup"),
          position: temp,
        );
        setState(() {
          markers.add(marker);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: selectedLocation != null
          ? Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(selectedLocation);
                },
                child: const Text("Select"),
              ),
            )
          : null,
      body: GoogleMap(
        myLocationButtonEnabled: true,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        onLongPress: (latlng) {
          print(latlng);
          var marker = Marker(
            markerId: const MarkerId("pickup"),
            position: latlng,
          );
          setState(() {
            markers.add(marker);
            selectedLocation = latlng;
          });
        },
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(18.5, 73.8),
          zoom: 8,
        ),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_controller.isCompleted) {
      disposeController();
    }
    super.dispose();
  }

  disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }
}

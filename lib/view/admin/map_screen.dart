import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Timer? timer;
  GoogleMapController? controller;
  DataController? dataController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      37.42796133580664,
      -122.085749655962,
    ),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(
      37.43296265331129,
      -122.08832357078792,
    ),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        getUpdatedLocation();
      });
    });
    super.initState();
  }

  getUpdatedLocation() async {
    dataController?.getVehicles();
    // controller = await _controller.future;
    // controller?.moveCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //       target: LatLng(
    //         double.parse(dataController?.vehicles.first.latitude ?? "0"),
    //         double.parse(dataController?.vehicles.first.longitude ?? '0'),
    //       ),
    //       zoom: 18.0,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    dataController = Provider.of<DataController>(context);

    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        onCameraMove: (onCameraMove) {},
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: dataController!.vehicles
            .map(
              (e) => Marker(
                markerId: MarkerId(e.vehicleid ?? ''),
                position: LatLng(
                  double.parse(e.latitude ?? "0"),
                  double.parse(e.longitude ?? '0'),
                ),
                infoWindow: InfoWindow(title: e.platno ?? ''),
              ),
            )
            .toSet(),
        initialCameraPosition: dataController != null &&
                dataController!.vehicles.isNotEmpty
            ? CameraPosition(
                target: LatLng(
                double.parse(dataController?.vehicles.first.latitude ?? "0"),
                double.parse(dataController?.vehicles.first.longitude ?? '0'),
              ))
            : _kGooglePlex,
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
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    super.dispose();
  }

  disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }
}

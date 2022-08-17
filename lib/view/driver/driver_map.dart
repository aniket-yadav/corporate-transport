import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class DriverMap extends StatefulWidget {
  const DriverMap({Key? key}) : super(key: key);

  @override
  State<DriverMap> createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      19.1279314,
      72.948004,
    ),
    zoom: 14.4746,
  );
  int count = 0;
  Timer? timer;
  GoogleMapController? controller;
  DataController? dataController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DataController>(context, listen: false).getMyPaasengers();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        getUpdatedLocation();
      });
    });
  }

  getUpdatedLocation() async {
    dataController?.getVehicle();
    controller = await _controller.future;
    if (count < 2) {
      count++;
      controller?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              double.parse(dataController?.vehicle?.latitude ?? "0"),
              double.parse(dataController?.vehicle?.longitude ?? '0'),
            ),
            zoom: 18.0,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    super.dispose();
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
        markers: {
          Marker(
            markerId: MarkerId(dataController?.vehicle?.vehicleid ?? ''),
            position: LatLng(
              double.parse(dataController?.vehicle?.latitude ?? "0"),
              double.parse(dataController?.vehicle?.longitude ?? '0'),
            ),
            infoWindow:
                InfoWindow(title: dataController?.vehicle?.platno ?? ''),
          ),
          ...dataController!.myPassengers
              .map(
                (e) => Marker(
                  markerId: MarkerId(e.employeeid ?? ''),
                  position: LatLng(
                    double.parse(e.latitude ?? "0"),
                    double.parse(e.longitude ?? '0'),
                  ),
                  infoWindow: InfoWindow(title: e.name ?? ''),
                ),
              )
              .toList(),
        },
        initialCameraPosition: dataController?.vehicle != null
            ? CameraPosition(
                target: LatLng(
                double.parse(dataController?.vehicle?.latitude ?? "0"),
                double.parse(dataController?.vehicle?.longitude ?? '0'),
              ))
            : _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

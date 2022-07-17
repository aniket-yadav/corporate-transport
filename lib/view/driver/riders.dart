import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/enum/riding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class Riders extends StatefulWidget {
  const Riders({Key? key}) : super(key: key);

  @override
  State<Riders> createState() => _RidersState();
}

class _RidersState extends State<Riders> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      dataController.getMyPaasengers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: ListView.builder(
        itemCount: dataController.myPassengers.length,
        itemBuilder: ((context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8.0,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 15.0,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.3,
                        child: const Icon(
                          Icons.account_circle,
                          size: 70,
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataController.myPassengers[index].name ?? '',
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              dataController.myPassengers[index].mobile ?? '',
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Riding",
                                  style: TextStyle(
                                    color: Color(0xff192921),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 25,
                                  width: 50,
                                  child: FlutterSwitch(
                                      activeColor: const Color(0xFF107189),
                                      value: dataController
                                              .myPassengers[index].riding ==
                                          Riding.yes.name,
                                      onToggle: (v) {
                                        dataController.updateRidingStatus(
                                            userid: dataController
                                                    .myPassengers[index]
                                                    .employeeid ??
                                                '',
                                            status: dataController
                                                        .myPassengers[index]
                                                        .riding ==
                                                    Riding.yes.name
                                                ? Riding.no.name
                                                : Riding.yes.name);
                                      }),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}

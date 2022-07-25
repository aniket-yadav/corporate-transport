import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'dart:io';
import 'package:intl/intl.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({Key? key}) : super(key: key);
  static const routeName = "/feedbacks";
  @override
  State<Feedbacks> createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      dataController.getFeedbacks();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Feedbacks",
        ),
        actions: [
          if (dataController.feedBacks.isNotEmpty)
            IconButton(
              onPressed: () {
                createExcel();
              },
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              ),
            ),
        ],
      ),
      body: ListView.builder(
          itemCount: dataController.feedBacks.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff00000D),
                    blurRadius: 16,
                    spreadRadius: -17,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          dataController.feedBacks[index].comment ?? '',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.star,
                        color: Color(0xf3b3b3bb),
                      ),
                      Text(
                        dataController.feedBacks[index].rate ?? '',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Email: ",
                      ),
                      Text(dataController.feedBacks[index].email ?? ''),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("User: "),
                      Text(dataController.feedBacks[index].author ?? ''),
                      const Spacer(),
                      const Text("Date: "),
                      Text(Jiffy(dataController.feedBacks[index].date ?? '')
                          .format('dd MMM yyyy')),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future<Directory?> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    }
    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  Future<bool> _requestPermissions() async {
    var permissionStorage = await Permission.storage.status.isGranted;
    if (permissionStorage) {
      return true;
    }
    var status = await Permission.storage.request();
    return status == PermissionStatus.granted;
  }

  Future<void> createExcel() async {
    final feedbacks =
        Provider.of<DataController>(context, listen: false).feedBacks;
    final isPermissionStatusGranted = await _requestPermissions();
    final dir = await _getDownloadDirectory();
    if (isPermissionStatusGranted) {
      final excel.Workbook workbook = excel.Workbook();
      final excel.Worksheet sheet = workbook.worksheets[0];
      sheet.getRangeByName("A1").setText("Feedback Id");
      sheet.getRangeByName("B1").setText("Comment");
      sheet.getRangeByName("C1").setText("Author");
      sheet.getRangeByName("D1").setText("Rate");
      sheet.getRangeByName("E1").setText("Email");
      sheet.getRangeByName("F1").setText("Date");
      int i = 2;
      for (var element in feedbacks) {
        sheet.getRangeByName("A$i").setText(element.feedbackid);
        sheet.getRangeByName("B$i").setText(element.comment);
        sheet.getRangeByName("C$i").setText(element.author);
        sheet.getRangeByName("D$i").setText(element.rate);
        sheet.getRangeByName("E$i").setText(element.email);
        sheet.getRangeByName("F$i").setText(element.date);

        i += 1;
      }

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      // final String path = (await getApplicationSupportDirectory()).path;
      final String path = dir?.path ?? "/storage/emulated/0/Download";
      final String fileName =
          "$path/${DateFormat("ddMMyyyyhhmm").format(DateTime.now())}.xlsx";
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }
}

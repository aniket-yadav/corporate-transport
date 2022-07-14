import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

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
}

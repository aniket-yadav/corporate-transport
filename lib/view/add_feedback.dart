import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/widgets/custom_number_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddFeedback extends StatefulWidget {
  const AddFeedback({Key? key}) : super(key: key);
  static const routeName = "/addFeedback";
  @override
  State<AddFeedback> createState() => _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedback> {
  int rate = 5;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Comment",
                ),
                minLines: 4,
                maxLines: null,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp("[a-zA-Z0-9. ]"),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: const Text("Give rate to us"),
            ),
            CustomNumberSelection(
                minValue: 1,
                maxValue: 5,
                currentValue: rate,
                onChanged: (v) {
                  setState(() {
                    rate = v;
                  });
                }),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final comment = commentController.text.trim();

                  final dataProvider =
                      Provider.of<DataController>(context, listen: false);
                  dataProvider.addFeedback(comment: comment, rate: rate);
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddFamily extends StatefulWidget {
  const AddFamily({Key? key}) : super(key: key);

  static const routeName = "/addFamily";
  @override
  State<AddFamily> createState() => _AddFamilyState();
}

class _AddFamilyState extends State<AddFamily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  static const routeName = "/chat";
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/controller/firebase_database.dart';
import 'package:corporatetransportapp/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  static const routeName = "/chat";
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseDatabase.getChats(
                  vehicle: dataController.user.vehicleid ?? ''),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.hasData) {
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ChatBubble(
                          user: data['user'] ?? '',
                          text: data['message'],
                          isCurrentUser:
                              dataController.user.name == data['user']);
                    }).toList(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10,
            ),
            child: TextField(
              controller: chatController,
              decoration: InputDecoration(
                filled: true,
                suffixIconConstraints: const BoxConstraints(maxWidth: 80),
                suffix: GestureDetector(
                  onTap: () {
                    FirebaseDatabase.sendMessage(
                      user: dataController.user.name ?? '',
                      message: chatController.text.trim(),
                      vehicle: dataController.user.vehicleid ?? '',
                    ).then((value) {
                      chatController.text = '';
                    });
                  },
                  child: const Icon(Icons.send),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:corporatetransportapp/assets/custom_theme.dart';
import 'package:corporatetransportapp/route/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TransportApp());
}

class TransportApp extends StatelessWidget {
  const TransportApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      theme: customTheme,
    );
  }
}

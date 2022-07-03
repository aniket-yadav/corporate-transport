import 'package:corporatetransportapp/assets/custom_theme.dart';
import 'package:corporatetransportapp/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//API key -  AIzaSyCjlgdj4BdbdMMpjwmWqnPbiTLmSgftBLY
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

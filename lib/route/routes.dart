import 'package:corporatetransportapp/view/splash_screen.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (_) => const SplashScreen(),
};

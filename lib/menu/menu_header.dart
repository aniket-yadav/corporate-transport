import 'package:flutter/material.dart';

class MenuHeader extends StatefulWidget {
  const MenuHeader({Key? key}) : super(key: key);

  @override
  _MenuHeaderState createState() => _MenuHeaderState();
}

class _MenuHeaderState extends State<MenuHeader> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        height: 120,
        width: constraints.maxWidth * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Corporate Transport App",
              style: TextStyle(
                color: Color(0xFF107189),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    });
  }
}

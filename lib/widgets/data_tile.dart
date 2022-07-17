import 'package:flutter/material.dart';

class DataTile extends StatelessWidget {
  final String label;
  final IconData? icon;
  const DataTile({Key? key, this.icon, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        top: 20.0,
        right: 20.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFcfe3e7),
              blurRadius: 2,
            )
          ]),
      padding: const EdgeInsets.all(
        10.0,
      ),
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: const Color(0xFF107189),
            ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

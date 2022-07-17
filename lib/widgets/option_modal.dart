import 'package:flutter/material.dart';

Future<dynamic> showOptionModal(
    BuildContext context, dynamic selectedValue, List<dynamic> options) async {
  return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 25.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: options.map((e) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, e);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      e ?? '',
                      style: TextStyle(
                        color: e == selectedValue
                            ? const Color(0xFF107189)
                            : const Color(0xFF291921),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      });
}

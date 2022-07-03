import 'package:flutter/material.dart';

class GenderRadio extends StatelessWidget {
  final String value, groupValue;
  final void Function(String) setSeletedGender;
  const GenderRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.setSeletedGender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      key: key,
      children: [
        Radio(
          activeColor: const Color(0xFF107189),
          value: value,
          groupValue: groupValue,
          onChanged: (v) {
            setSeletedGender(value);
          },
        ),
        Text(
          value,
          style: TextStyle(
            color: theme.textTheme.headline1!.color,
            fontSize: 14.0,
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomNumberSelection extends StatefulWidget {
  final int minValue, maxValue, currentValue;

  final void Function(int) onChanged;
  const CustomNumberSelection({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomNumberSelection> createState() => _CustomNumberSelectionState();
}

class _CustomNumberSelectionState extends State<CustomNumberSelection> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          alignment: Alignment.center,
          height: 40,
        ),
        Positioned(
            child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: const Offset(
                  0.0, // Move to right 10  horizontally
                  0.0, // Move to bottom 10 Vertically
                ),
              ),
            ],
          ),
        )),
        Container(
          alignment: Alignment.center,
          child: NumberPicker(
            axis: Axis.horizontal,
            itemHeight: 45,
            itemWidth: 45.0,
            step: 1,
            selectedTextStyle: const TextStyle(
              fontSize: 20.0,
              color: Color(0xff107189),
              fontWeight: FontWeight.w700,
            ),
            textStyle: const TextStyle(
              fontSize: 13.0,
            ),
            itemCount: 7,
            value: widget.currentValue,
            minValue: widget.minValue,
            maxValue: widget.maxValue,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}

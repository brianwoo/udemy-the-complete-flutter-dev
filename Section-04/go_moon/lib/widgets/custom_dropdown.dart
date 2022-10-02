import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDropdownButton extends StatelessWidget {
  List<String> values;
  double width;

  CustomDropdownButton({super.key, required this.values, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      width: width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(53, 53, 53, 10.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
        underline: Container(),
        value: values.first,
        items: values.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        onChanged: (value) {},
        dropdownColor: const Color.fromRGBO(53, 53, 53, 1.0),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

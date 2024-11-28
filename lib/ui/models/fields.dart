import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medapp/ui/functions.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final OnTap? onTap;
  const InputField({
    super.key,
    required this.title,
    required this.hint,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Expanded(
              child: TextFormField(
            autofocus: false,
            controller: controller,
            style: subHeadingStyle,
            decoration: InputDecoration(
              filled: true,
              hintText: hint,
              hintStyle: subHeadingStyle,
            ),
          ))
        ],
      ),
    );
  }
}

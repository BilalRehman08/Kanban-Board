import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../utils/colors.dart';

Widget customFormTextField({
  required String name,
  TextEditingController? controller,
  String? labelText,
  required String hintText,
  bool obscureText = false,
  IconButton? suffixIcon,
  double padding = 8,
  FocusNode? focusNode,
  required String? Function(String?)? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          labelText ?? "",
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: ColorUtils.primaryColor),
        ),
      ),
      FormBuilderTextField(
        controller: controller,
        name: name,
        focusNode: focusNode,
        style: const TextStyle(color: ColorUtils.whiteColor),
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          filled: true,
          focusColor: ColorUtils.textFieldGrey,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: ColorUtils.textFieldGrey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: ColorUtils.greyColor),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    ],
  );
}

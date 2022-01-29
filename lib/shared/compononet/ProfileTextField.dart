
import 'dart:core';

import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? type;
  Function(String?)? onSubmit,onChange, onPressed;
  Function()? onTap;
  String? Function(String?)? validate;
  bool? isPassword=false;
  bool? isClickable=true;
  Function(String?)? onSave;
  String? label,hint;
  IconData? prefix,suffix;
  Function()? suffixPressed;

  ProfileTextField({
      this.controller,
      this.type,
      this.onSubmit,
      this.onChange,
      this.onPressed,
      this.onTap,
      this.validate,
      this.isPassword,
      this.isClickable,
      this.onSave,
      this.label,
      this.hint,
      this.prefix,
      this.suffix,
      this.suffixPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: const EdgeInsets.only(right: 0),
      textAlign: TextAlign.start,
      controller: controller,
      keyboardType: type,
      // obscureText: isPassword!,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      onSaved: onSave,
      validator: validate,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[400],
        ),
        prefixIcon: Icon(prefix, color: Colors.red[50]!),
        suffixIcon: suffix != null ? IconButton(onPressed: suffixPressed, icon: Icon(suffix,),): null,
        // border: OutlineInputBorder(),
      ),
    );
  }
}

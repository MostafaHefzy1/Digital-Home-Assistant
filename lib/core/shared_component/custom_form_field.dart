import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/app_color.dart';

class CustomFormField extends StatelessWidget {
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String? value) validate;
  final String text;
  final Function? onFieldSubmit;
  final IconData? prefixIcon;
  final bool isPassword;
  final IconData? suffixIcon;
  final Function? suffixOnPressed;
  final bool? underLine;
  final bool? textLabel;

  const CustomFormField({
    super.key,
    required this.type,
    required this.controller,
    required this.validate,
    required this.text,
    this.onFieldSubmit,
    this.prefixIcon,
    this.isPassword = false,
    this.suffixIcon,
    this.suffixOnPressed,
    this.underLine = false,
    this.textLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    style: TextStyle(color: AppColors.whiteColor),
      keyboardType: type,
      controller: controller,
      onFieldSubmitted: (String value) {
        onFieldSubmit!(value);
      },
      validator: (value) {
        return validate(value);
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        hintText: textLabel == false ? text : null,
        label: textLabel != false ? Text(text) : null,
        hintStyle: Theme.of(context)
            .textTheme
            .subtitle1
            ?.copyWith(fontSize: 13, color: AppColors.whiteColor),
        prefixIcon: Icon(
          prefixIcon,
          size: 22.w,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  size: 22.w,
                ),
                onPressed: () {
                  suffixOnPressed!();
                })
            : null,
        enabledBorder: underLine == true ? InputBorder.none : null,
        focusedBorder: underLine == true ? InputBorder.none : null,
        border: underLine == true ? InputBorder.none : null,
      ),
    );
  }
}

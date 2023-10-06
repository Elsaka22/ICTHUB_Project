import 'package:flutter/material.dart';
import 'package:icthub_2/colors.dart';
import "package:flutter_svg/flutter_svg.dart";

class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final  String? Function(String?)?validator;
  Widget? prefixIcon;
  TextInputType? keyboardType;


   MyFormField({super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
     this.prefixIcon,
     this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: TextFormField(
        controller: controller,
        decoration:  InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.border,
            ),
          ),
          focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ) ,
          contentPadding:const EdgeInsets.all(8),
          fillColor: AppColors.formText,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.hintText,
            fontSize: 18,
            fontFamily: 'Urbanist',
          ),
          prefixIcon: prefixIcon,


        ),
        validator: validator,

      ),
    );
  }
}

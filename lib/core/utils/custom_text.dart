// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../constant/colors.dart';



// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  CustomText(
      {required this.name,
      this.size,
      this.familyFont = "Montserrat",
      this.fontweight,
      this.alignment,
      this.fontStyle,
      this.height,
      this.color = black,
      super.key});
  final String name;
  double? size;
  String? familyFont;
  FontWeight? fontweight;
  TextAlign? alignment;
  double? height;
  FontStyle? fontStyle;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      textAlign: alignment,
      style: TextStyle(
          fontSize: size,
          height: height,
          fontFamily: familyFont,
          fontStyle: fontStyle,
          color: color,
          fontWeight: fontweight),
    );
  }
}

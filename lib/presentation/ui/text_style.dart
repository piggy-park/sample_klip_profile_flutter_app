// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum KlipTextStyle {
  K_28B(28, FontWeight.bold, 1.4, -1.2),
  K_22B(22, FontWeight.bold, 1.4, -0.9),
  K_20B(20, FontWeight.bold, 1.5, -0.8),
  K_20M(20, FontWeight.normal, 1.5, -0.8),
  K_18B(18, FontWeight.bold, 1.5, -0.7),
  K_18M(18, FontWeight.normal, 1.5, -0.7),
  K_16SB(16, FontWeight.w600, 1.5, -0.5),
  K_16M(16, FontWeight.normal, 1.5, -0.5),
  K_15SB(15, FontWeight.w600, 1.5, -0.3),
  K_15M(15, FontWeight.normal, 1.5, -0.3),
  K_14SB(14, FontWeight.w600, 1.5, -0.3),
  K_14M(14, FontWeight.normal, 1.5, -0.3),
  K_12M(12, FontWeight.normal, 1.4, -0.1),
  K_11B(11, FontWeight.bold, 1.4, 0);

  static const String fontFamily = 'Pretendard';

  const KlipTextStyle(
      this.fontSize, this.fontWeight, this.height, this.letterSpacing);
  final double fontSize;
  final double height;
  final double letterSpacing;
  final FontWeight fontWeight;

  TextStyle style({Color? color = Colors.black}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }
}

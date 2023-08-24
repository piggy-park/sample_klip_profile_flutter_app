// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum KlipColorStyle {
  Violet('#9D70FF'),
  Violet100('#A77EFF'),
  Violet200('#B18CFF'),
  Violet300('#BB9BFF'),
  Violet400('#C4A9FF'),
  Violet500('#CEB7FF'),
  Violet600('#D8C6FF'),
  Violet700('#E2D4FF'),
  Violet800('#EBE2FF'),
  Violet900('#F6F1FF'),
  Blue('#2D6AFF'),
  Blue100('#4279FF'),
  Blue200('#5788FF'),
  Blue300('#6C97FF'),
  Blue400('#81A6FF'),
  Blue500('#95B4FF'),
  Blue600('#ABC3FF'),
  Blue700('#C0D3FF'),
  Blue800('#D5E1FF'),
  Blue900('#EAF1FF'),
  Sky('#628FFF'),
  Sky100('#729BFF'),
  Sky200('#81A6FF'),
  Sky300('#91B1FF'),
  Sky400('#A1BCFF'),
  Sky500('#B0C7FF'),
  Sky600('#C0D2FF'),
  Sky700('#D0DEFF'),
  Sky800('#E0E9FF'),
  Sky900('#F0F4FF'),
  Green('#8AC923'),
  Green100('#96CE39'),
  Green200('#A1D44F'),
  Green300('#ADD965'),
  Green400('#B9DE7B'),
  Green500('#C4E491'),
  Green600('#D0E9A7'),
  Green700('#DCEFBD'),
  Green800('#E8F4D3'),
  Green900('#F3FAE9'),
  Yellow('#FFDB25'),
  Yellow100('#FFDF3B'),
  Yellow200('#FFE251'),
  Yellow300('#FFE667'),
  Yellow400('#FFE97C'),
  Yellow500('#FFEC92'),
  Yellow600('#FFF1A8'),
  Yellow700('#FFF5BE'),
  Yellow800('#FFF8D3'),
  Yellow900('#FFFCEA'),
  Gray('#333539'),
  Gray100('#494B4E'),
  Gray200('#616265'),
  Gray300('#77787A'),
  Gray400('#8D8E90'),
  Gray500('#A4A5A7'),
  Gray600('#BBBCBD'),
  Gray700('#D2D2D3'),
  Gray800('#E9E9E9'),
  Gray900('#F5F5F5'),
  Black('#1C1E22'),
  Black_a70('#1C1E22', 0.7),
  Black_a40('#1C1E22', 0.4),
  Black_a20('#1C1E22', 0.2),
  Black_a10('#1C1E22', 0.1),
  Black_a5('#1C1E22', 0.05),
  Black_a0('#1C1E22', 0),
  White('#FFFFFF'),
  White_a70('#FFFFFF', 0.7),
  White_a40('#FFFFFF', 0.4),
  White_a0('#FFFFFF', 0),
  Red('#FA2B5C'),
  Red900('#FFEAEF'),
  EthViolet('#464A76'),
  KlaytnOrange('#FD5C38'),
  PolygonViolet('#7C45D8'),
  ShadowGray('#F0F1F5');

  const KlipColorStyle(this.code, [this.alpha = 1.0]);
  final String code;
  final double alpha;

  Color color([double alpha = 1.0]) {
    if (this.alpha != 1.0) {
      return code.toColor(this.alpha);
    }
    return code.toColor(alpha);
  }
}

enum KlipGradientStyle {
  Black_a70to0([KlipColorStyle.Black_a70, KlipColorStyle.Black_a0]),
  White_a0to100([KlipColorStyle.White_a0, KlipColorStyle.White]),
  White_a0to100v([KlipColorStyle.White_a0, KlipColorStyle.White]);

  const KlipGradientStyle(this.colorStyles);
  final List<KlipColorStyle> colorStyles;

  List<Color> get colors {
    return colorStyles.map((e) => e.color()).toList();
  }

  Gradient get gradient {
    switch (this) {
      case Black_a70to0:
        return LinearGradient(
            colors: colors,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter);
      case White_a0to100v:
        return LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter);
      default:
        return LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight);
    }
  }
}

extension ColorExtension on String {
  toColor([double alpha = 1.0]) {
    var alphaHex = (alpha * 255).toInt().toRadixString(16);
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write(alphaHex);
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

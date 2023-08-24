import 'package:flutter/material.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/color_style.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/text_style.dart';

enum KlipButtonStyle {
  primary(),
  secondary(),
  icon(),
  smallBoxGray(),
  smallBoxBlue();

  ButtonStyle buttonStyle() {
    switch (this) {
      case KlipButtonStyle.secondary:
        return ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return KlipTextStyle.K_14SB
                .style(color: KlipColorStyle.Gray600.color());
          }
          return KlipTextStyle.K_14SB.style(color: KlipColorStyle.Blue.color());
        }), backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return KlipColorStyle.Gray900.color();
          }
          return KlipColorStyle.Blue900.color();
        }), overlayColor: MaterialStateProperty.resolveWith((state) {
          if (state.contains(MaterialState.pressed)) {
            return KlipColorStyle.Black_a10.color();
          }
          return Colors.transparent;
        }));
      case KlipButtonStyle.icon:
        return ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return KlipTextStyle.K_14SB
                .style(color: KlipColorStyle.Red.color(0.2));
          }
          return KlipTextStyle.K_14SB.style(color: KlipColorStyle.Red.color());
        }), backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return KlipColorStyle.Gray900.color();
          }
          return KlipColorStyle.Red900.color();
        }), overlayColor: MaterialStateProperty.resolveWith((state) {
          if (state.contains(MaterialState.pressed)) {
            return KlipColorStyle.Black_a10.color();
          }
          return Colors.transparent;
        }));
      case KlipButtonStyle.smallBoxGray:
        return ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) {
          return KlipTextStyle.K_14SB
              .style(color: KlipColorStyle.Gray300.color());
        }), backgroundColor: MaterialStateProperty.resolveWith((states) {
          return KlipColorStyle.Gray900.color();
        }), overlayColor: MaterialStateProperty.resolveWith((state) {
          if (state.contains(MaterialState.pressed)) {
            return KlipColorStyle.Black_a10.color();
          }
          return Colors.transparent;
        }));
      case KlipButtonStyle.smallBoxBlue:
        return ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) {
          return KlipTextStyle.K_14SB.style(color: KlipColorStyle.Blue.color());
        }), backgroundColor: MaterialStateProperty.resolveWith((states) {
          return KlipColorStyle.Blue900.color();
        }), overlayColor: MaterialStateProperty.resolveWith((state) {
          if (state.contains(MaterialState.pressed)) {
            return KlipColorStyle.Black_a10.color();
          }
          return Colors.transparent;
        }));
      default:
        return ButtonStyle(
            textStyle: MaterialStatePropertyAll(KlipTextStyle.K_14SB
                .style(color: KlipColorStyle.White.color())),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return KlipColorStyle.Gray700.color();
              }
              return KlipColorStyle.Blue.color();
            }),
            overlayColor: MaterialStateProperty.resolveWith((state) {
              if (state.contains(MaterialState.pressed)) {
                return KlipColorStyle.Black_a10.color();
              }
              return Colors.transparent;
            }));
    }
  }

  String loadingImg() {
    if (this == KlipButtonStyle.primary) {
      return 'images/atom/picto/fill/pf_loading_white.svg';
    } else if (this == KlipButtonStyle.secondary) {
      return 'images/atom/picto/fill/pf_loading_blue.svg';
    } else if (this == KlipButtonStyle.icon) {
      return 'images/atom/picto/fill/pf_loading_red.svg';
    }
    return '';
  }

  double sizeImg() {
    if (this == KlipButtonStyle.smallBoxBlue ||
        this == KlipButtonStyle.smallBoxGray) {
      return 16;
    }
    return 24;
  }
}

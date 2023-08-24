import 'package:flutter/material.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/color_style.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/klip_image.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/text_style.dart';
import 'package:oktoast/oktoast.dart';

enum KlipSnackBarStyle {
  bottom,
  top;
}

class KlipSnackBar extends StatefulWidget {
  const KlipSnackBar(
      {Key? key,
      required this.style,
      required this.text,
      this.showIcon = false,
      this.buttonTitle,
      this.buttonAction})
      : super(key: key);

  final KlipSnackBarStyle style;
  final String text;
  final bool showIcon;
  final String? buttonTitle;
  final VoidCallback? buttonAction;

  @override
  State<KlipSnackBar> createState() => _KlipSnackBarState();
}

ToastFuture showKlipSnackBar(
    {Key? key,
    required BuildContext context,
    required KlipSnackBarStyle style,
    required String text,
    bool showIcon = false,
    String? buttonTitle,
    VoidCallback? buttonAction}) {
  final snack = KlipSnackBar(
    style: style,
    text: text,
    showIcon: showIcon,
    buttonTitle: buttonTitle,
    buttonAction: buttonAction,
  );
  var position = ToastPosition(
      align: Alignment.bottomCenter,
      offset: -MediaQuery.of(context).padding.bottom);
  if (style == KlipSnackBarStyle.top) {
    position = ToastPosition(
        align: Alignment.topCenter, offset: MediaQuery.of(context).padding.top);
  }

  return showToastWidget(
    snack,
    context: context,
    position: position,
    handleTouch: true,
    duration: buttonAction != null ? const Duration(seconds: 0) : null,
  );
}

class _KlipSnackBarState extends State<KlipSnackBar> {
  final GlobalKey _containerKey = GlobalKey();
  Size? size;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        size = _getSize();
      });
    });
  }

  Size? _getSize() {
    if (_containerKey.currentContext != null) {
      final RenderBox renderBox =
          _containerKey.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }
    return Size.zero;
  }

  Size? _textSize(String text, TextStyle style) {
    if (size == null) return null;
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr)
      ..layout(minWidth: size?.width ?? 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  Widget _snack() {
    var text = widget.text;
    var textStyle = KlipTextStyle.K_14SB.style(
      color: KlipColorStyle.White.color(),
    );
    var sizeText = _textSize(text, textStyle);

    var margin = const EdgeInsets.fromLTRB(16, 0, 16, 16);
    if (widget.style == KlipSnackBarStyle.top) {
      margin = const EdgeInsets.fromLTRB(16, 8, 16, 0);
    }

    return Container(
      decoration: BoxDecoration(
        color: widget.style == KlipSnackBarStyle.bottom
            ? KlipColorStyle.Gray.color()
            : KlipColorStyle.Gray400.color(),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(16),
      margin: margin,
      height: (sizeText?.height ?? 100) + 32,
      child: Stack(
        children: [
          widget.showIcon
              ? Positioned.fromRect(
                  rect: const Rect.fromLTRB(0, 0, 16, 21),
                  child: const KlipImage(
                    filePath: 'images/atom/picto/fill/pf_fail_red.svg',
                    width: 16,
                    height: 16,
                  ),
                )
              : Container(),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.showIcon
                  ? const SizedBox(
                      width: 16 + 6,
                    )
                  : Container(),
              Expanded(
                child: Text(
                  text,
                  style: textStyle,
                  key: _containerKey,
                ),
              ),
              widget.buttonTitle != null
                  ? const SizedBox(
                      width: 24,
                    )
                  : Container(),
              widget.buttonTitle != null
                  ? GestureDetector(
                      onTap: () {
                        widget.buttonAction!();
                      },
                      child: Center(
                        child: Text(
                          '버튼',
                          style: KlipTextStyle.K_14SB.style(
                              color: widget.style == KlipSnackBarStyle.bottom
                                  ? KlipColorStyle.Sky300.color()
                                  : KlipColorStyle.Sky700.color()),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _snack();
  }
}

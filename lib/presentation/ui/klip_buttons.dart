import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/button_style.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/klip_image.dart';

class KlipButtons extends StatefulWidget {
  const KlipButtons(
      {Key? key,
      required this.klipButtonStyle,
      this.width,
      this.height = 52,
      this.isDisabled = false,
      this.isLoading = false,
      this.isAnimation = true,
      this.onTap,
      this.title = '',
      this.image = '',
      this.child})
      : super(key: key);

  const KlipButtons.title(
      {Key? key,
      required this.title,
      required this.klipButtonStyle,
      this.width,
      this.height = 52,
      this.isDisabled = false,
      this.isLoading = false,
      this.isAnimation = true,
      this.onTap})
      : image = '',
        child = null,
        super(key: key);

  const KlipButtons.image(
      {Key? key,
      required this.image,
      required this.klipButtonStyle,
      this.width,
      this.height = 52,
      this.isDisabled = false,
      this.isLoading = false,
      this.isAnimation = true,
      this.onTap})
      : title = '',
        child = null,
        super(key: key);

  const KlipButtons.child(
      {Key? key,
      required this.child,
      required this.klipButtonStyle,
      this.width,
      this.height = 52,
      this.isDisabled = false,
      this.isLoading = false,
      this.isAnimation = true,
      this.onTap})
      : title = '',
        image = '',
        super(key: key);

  final bool isDisabled;
  final bool isLoading;
  final bool isAnimation;
  final KlipButtonStyle klipButtonStyle;
  final VoidCallback? onTap;

  final String title;
  final String image;
  final Widget? child;

  final double? width;
  final double? height;

  @override
  State<KlipButtons> createState() => _KlipButtonsState();
}

class _KlipButtonsState extends State<KlipButtons>
    with TickerProviderStateMixin {
  late ButtonStyle _buttonStyle;
  double dScale = 1;
  late AnimationController _animationScale;
  double dRotate = 0;
  late AnimationController _animationRotate;

  Set<MaterialState> state = {MaterialState.selected};

  @override
  void initState() {
    _buttonStyle = widget.klipButtonStyle.buttonStyle();
    _animationScale = AnimationController(
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1,
      value: 1,
      vsync: this,
    );
    _animationScale.addListener(() {
      setState(() {
        dScale = _animationScale.value;
      });
    });
    _animationRotate = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
        lowerBound: 0,
        upperBound: 1,
        value: 0);
    _animationRotate.addListener(() {
      setState(() {
        dRotate = _animationRotate.value;
      });
      if (_animationRotate.isCompleted) {
        _animationRotate.repeat();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationScale.dispose();
    _animationRotate.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(KlipButtons oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading) {
      _animationRotate.forward();
    } else {
      _animationRotate.stop();
      _animationRotate.value = 0;
    }

    if (widget.isDisabled) {
      state.add(MaterialState.disabled);
    } else {
      state.remove(MaterialState.disabled);
    }
  }

  bool activeAnimation() {
    return !state.contains(MaterialState.disabled) && widget.isAnimation;
  }

  Widget content() {
    Widget content = const Text('');
    if (widget.child != null) {
      content = widget.child!;
    } else if (widget.title.isNotEmpty && widget.image.isNotEmpty) {
      content = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: _buttonStyle.textStyle?.resolve(state),
            ),
            const SizedBox(
              width: 4,
            ),
            SizedBox(
              width: widget.klipButtonStyle.sizeImg(),
              height: widget.klipButtonStyle.sizeImg(),
              child: KlipImage(
                filePath: widget.image,
              ),
            )
          ],
        ),
      );
    } else if (widget.title.isNotEmpty) {
      content = Text(
        widget.title,
        style: _buttonStyle.textStyle?.resolve(state),
      );
    } else if (widget.image.isNotEmpty) {
      content = SizedBox(
        width: widget.klipButtonStyle.sizeImg(),
        height: widget.klipButtonStyle.sizeImg(),
        child: KlipImage(
          filePath: widget.image,
        ),
      );
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (activeAnimation()) {
          _animationScale.reverse().then((value) {
            _animationScale.forward().then((value) {
              state.remove(MaterialState.pressed);
            });
          });
        }
        if (!state.contains(MaterialState.disabled)) {
          widget.onTap?.call();
        }
      },
      onTapDown: (details) {
        state.add(MaterialState.pressed);
        if (activeAnimation()) {
          _animationScale.reverse();
        }
      },
      onTapCancel: () {
        state.remove(MaterialState.pressed);
        if (activeAnimation()) {
          _animationScale.forward();
        }
      },
      child: Transform.scale(
        scale: dScale,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _buttonStyle.backgroundColor?.resolve(state),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: widget.isLoading &&
                      widget.klipButtonStyle.loadingImg().isNotEmpty
                  ? Transform.rotate(
                      angle: 2 * pi * dRotate,
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: KlipImage(
                          filePath: widget.klipButtonStyle.loadingImg(),
                        ),
                      ),
                    )
                  : content(),
            ),
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                color: _buttonStyle.overlayColor?.resolve(state),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

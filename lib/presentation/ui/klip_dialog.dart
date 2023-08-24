import 'package:flutter/material.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/color_style.dart';

class KlipDialog extends StatefulWidget {
  const KlipDialog({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<KlipDialog> createState() => _KlipDialogState();
}

Future<T?> showKlipDialog<T>(
    {Key? key, required BuildContext context, required Widget child}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return KlipDialog(child: child);
    },
  );
}

class _KlipDialogState extends State<KlipDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      backgroundColor: KlipColorStyle.White.color(),
      child: widget.child,
    );
  }
}

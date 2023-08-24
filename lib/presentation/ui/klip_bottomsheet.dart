import 'package:flutter/material.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/color_style.dart';

class KlipBottomSheet extends StatefulWidget {
  const KlipBottomSheet({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<KlipBottomSheet> createState() => _KlipBottomSheetState();
}

Future<T?> showKlipBottomSheet<T>(
    {Key? key, required BuildContext context, required Widget child}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return KlipBottomSheet(child: child);
    },
  );
}

class _KlipBottomSheetState extends State<KlipBottomSheet>
    with TickerProviderStateMixin {
  Widget _buildHandle() {
    return SizedBox(
      width: 40,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Container(
          height: 4.0,
          decoration: BoxDecoration(
            color: KlipColorStyle.Gray800.color(),
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }

  Widget _buildContents() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Wrap(
        children: [
          Column(
            children: [
              _buildHandle(),
              widget.child,
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContents();
  }
}

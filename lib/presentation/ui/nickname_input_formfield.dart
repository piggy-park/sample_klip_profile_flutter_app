import 'package:flutter/material.dart';

class TextFormFieldScreen extends StatefulWidget {
  const TextFormFieldScreen({super.key});

  @override
  State<TextFormFieldScreen> createState() => _TextFormFieldScreenState();
}

class _TextFormFieldScreenState extends State<TextFormFieldScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final int maxFieldLength = 20;
  String? errorMessage;
  int currentTextCount = 0;
  String userInputText = "";

  void updateCurrentTextCount(int currentTextCount) {
    setState(() {
      this.currentTextCount = currentTextCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF0F4FF),
                      blurRadius: 4,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: _textEditingController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(16, 16, 100, 16),
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333539),
                  ),
                  hintText: "닉네임 입력",
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF77787A)),
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF2D6AFF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFBBBCBD),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorText: errorMessage,
                  errorStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFA2B5C),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFFA2B5C),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFFA2B5C),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    if (value.length <= maxFieldLength) {
                      errorMessage = null;
                      userInputText = value;
                    } else {
                      errorMessage = "20자까지 입력할 수 있어요.";
                      _textEditingController.value = TextEditingValue(
                          text: userInputText,
                          selection: TextSelection(
                              baseOffset: maxFieldLength,
                              extentOffset: maxFieldLength,
                              affinity: TextAffinity.downstream,
                              isDirectional: false),
                          composing: TextRange(start: 0, end: maxFieldLength));
                    }
                  }
                  _textEditingController.text = userInputText;
                  updateCurrentTextCount(userInputText.length);
                },
              ),
              Positioned(
                right: 16,
                top: 16,
                child: Text(
                  '$currentTextCount/20',
                  style: const TextStyle(
                      color: Color(0xFF77787A),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

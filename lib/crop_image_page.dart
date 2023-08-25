import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_klip_profile_flutter_app/klip_profile_page.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/text_style.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/color_style.dart';

class CropImagePage extends StatelessWidget {
  final Uint8List imageData;
  final cropController = CropController();
  final profilePageController = Get.find<ProfilePageController>();

  CropImagePage({super.key, required this.imageData});

  void showImageSizeErrorPopup(
      {required String title, required String content}) {
    Get.dialog(AlertDialog(
      title: Text(
        title,
        style: KlipTextStyle.K_18B.style(color: KlipColorStyle.Black.color()),
      ),
      content: Text(
        content,
        style: KlipTextStyle.K_15M.style(color: KlipColorStyle.Gray300.color()),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back(closeOverlays: true);
            },
            child: const Text("확인"))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top: true,
      bottom: false,
      child: Scaffold(
        body: Column(
          children: [
            CropPageHeader(cropController: cropController),
            Visibility(
              // 로딩화면 필요시 조건 추가해야함.
              visible: imageData.length > 2,
              // 로딩 화면
              replacement: const Center(child: CircularProgressIndicator()),
              child: imageData.length > 2
                  ? Expanded(
                      child: Crop(
                        controller: cropController,
                        image: imageData,
                        onCropped: (cropped) {
                          // crop한 이미지 controller에 넘기고 dismiss함.
                          var originSize =
                              imageData.lengthInBytes / 1024 / 1024;
                          var croppedSize = cropped.lengthInBytes / 1024 / 1024;
                          print(
                              "originSize: ${originSize.toStringAsFixed(2)}mb croppedSize: ${croppedSize.toStringAsFixed(2)}mb");
                          if (croppedSize > 10) {
                            showImageSizeErrorPopup(
                                title: "업로드 용량을 초과했어요",
                                content: "최대 10MB까지 올릴 수 있어요.");
                          } else {
                            profilePageController
                                .setProfileWithCroppedImage(cropped);
                            Get.back();
                          }
                        },
                        initialSize: 0.9,
                        cornerDotBuilder: (size, cornerIndex) {
                          return const DotControl();
                        },
                        withCircleUi: true,
                        // 배경 색상
                        baseColor: Colors.black,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class CropPageHeader extends StatelessWidget {
  final CropController cropController;
  const CropPageHeader({super.key, required this.cropController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 48,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 28,
                height: 28,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.back();
                  },
                  icon: Image.asset(
                      "images/atom/picto/outline/po_back_black.png"),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  cropController.cropCircle();
                },
                child: Text(
                  "완료",
                  style: KlipTextStyle.K_16SB
                      .style(color: KlipColorStyle.Gray300.color()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// crop 버튼
  /*
      ElevatedButton(
      onPressed: () {
        isProcessing = true;
        _controller.cropCircle();
      },
  */
  /*
  // 크롭시 croppedData 처리
  // visable widget으로 처리 하면 될듯
  // data크기 10MB이상인지 체크 해야함.
      replacement: _croppedData != null
          ? SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.memory(
                _croppedData!,
                fit: BoxFit.contain,
              ),
            )
          : const SizedBox.shrink(),
    )
  */
  // 뒤로 가기 시 cropData 초기화 하기
  // onPressed: () => croppedData = null

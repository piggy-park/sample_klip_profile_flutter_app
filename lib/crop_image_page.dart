import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_klip_profile_flutter_app/klip_profile_page.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/text_style.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/color_style.dart';

class CropImagePage extends StatelessWidget {
  Uint8List imageData;
  final cropController = CropController();
  final profilePageController = Get.find<ProfilePageController>();

  var _isPreviewing = false;

  set isPreviewing(bool value) {
    // setState(() {
    _isPreviewing = value;
    // });
  }

  CropImagePage({super.key, required this.imageData});

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
                              (imageData.lengthInBytes / 1024 / 1024)
                                  .toStringAsFixed(2);
                          var croppedSize =
                              (cropped.lengthInBytes / 1024 / 1024)
                                  .toStringAsFixed(2);
                          print(
                              "originSize: ${originSize}mb croppedSize: ${croppedSize}mb");
                          profilePageController
                              .setProfileWithCroppedImage(cropped);
                          Get.back();
                        },
                        initialSize: 0.9,
                        cornerDotBuilder: (size, cornerIndex) {
                          return _isPreviewing
                              ? const SizedBox.shrink()
                              : const DotControl();
                        },
                        withCircleUi: true,
                        // 크롭 뷰 주변 딤 색상
                        maskColor: _isPreviewing ? Colors.white : null,
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
  CropController cropController;
  CropPageHeader({super.key, required this.cropController});

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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: () {
                    cropController.cropCircle();
                  },
                  child: Text(
                    "완료",
                    style: KlipTextStyle.K_16SB
                        .style(color: KlipColorStyle.Gray300.color()),
                  ))
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

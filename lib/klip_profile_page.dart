import 'dart:async';
import 'dart:typed_data';
import 'package:sample_klip_profile_flutter_app/crop_image_page.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/klip_image.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/text_style.dart';
import 'package:sample_klip_profile_flutter_app/presentation/ui/color_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class KlipProfilePage extends StatelessWidget {
  final ProfilePageController c = Get.put(ProfilePageController());

  KlipProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const KlipProfilePageHeader(),
            const SizedBox(height: 40),
            SelectedProfileImage(),
            const SizedBox(height: 16),
            const SelectableProfileImageGrid(),
          ],
        ),
      ),
    );
  }
}

class KlipProfilePageHeader extends StatelessWidget {
  const KlipProfilePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 28,
                height: 28,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Dismiss Profile Page
                    // context.router.pop();
                  },
                  icon: const KlipImage(
                      filePath: "images/atom/picto/outline/po_close_black.svg"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "오픈채팅",
                style: KlipTextStyle.K_18B.style(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedProfileImage extends GetView {
  final ProfilePageController c = Get.find<ProfilePageController>();

  SelectedProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ProfilePageController>(builder: (_) {
      // 크롭 이미지가 있다면 가져옴
      if (_.croppedImageData.value.length > 2) {
        return Container(
          width: 96,
          height: 96,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(52)),
          ),
          child: Image.memory(
            _.croppedImageData.value,
          ),
        );
      }
      // 그외 기본 프로필 이미지
      return Image.asset(width: 96, height: 96, _.selectedAssetImagePath());
    });
  }
}

class SelectableProfileImageGrid extends StatelessWidget {
  const SelectableProfileImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilePageController>(builder: (_) {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _.assetImageList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 12, crossAxisSpacing: 12, crossAxisCount: 5),
        itemBuilder: (context, index) {
          return SelectableProfileImage(
            assetImagePath: _.assetImageList[index],
          );
        },
      );
    });
  }
}

class SelectableProfileImage extends StatelessWidget {
  final String assetImagePath;

  SelectableProfileImage({
    super.key,
    required this.assetImagePath,
  });

  final ProfilePageController c = Get.find<ProfilePageController>();

  void _pickImage() {
    if (assetImagePath == "images/atom/btn_uploadImage.png") {
      c.getImageDataFromAlbum();
    } else {
      c.selectProfileImage(assetImagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ProfilePageController>(builder: (_) {
      return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(52)),
            border: Border.all(
                color: (_.selectedAssetImagePath.value == assetImagePath)
                    ? KlipColorStyle.Blue.color()
                    : Colors.transparent,
                width:
                    _.selectedAssetImagePath.value == assetImagePath ? 2 : 0),
          ),
          child: IconButton(
            onPressed: _pickImage,
            padding: EdgeInsets.zero,
            icon: Image.asset(
              assetImagePath,
              width: 52,
              height: 52,
            ),
          ));
    });
  }
}

class ProfilePageController extends GetxController {
  final List<String> assetImageList = [
    "images/atom/profile_default.png",
    "images/atom/profile-setting.png",
    "images/atom/profile-setting-1.png",
    "images/atom/profile-setting-2.png",
    "images/atom/profile-setting-3.png",
    "images/atom/profile-setting-4.png",
    "images/atom/profile-setting-5.png",
    "images/atom/profile-setting-6.png",
    "images/atom/profile-setting-7.png",
    "images/atom/btn_uploadImage.png"
  ];

  // default selected profile Image
  var selectedAssetImagePath = "images/atom/profile_default.png".obs;
  var croppedImageData = Uint8List(0).obs;

  selectProfileImage(assetImagePath) {
    // 업로드 이미지 (from 앨범, 카메라) 초기화
    croppedImageData.update((val) {
      croppedImageData = Rx(Uint8List(0));
    });

    selectedAssetImagePath.update((val) {
      // 기본 이미지 변경
      selectedAssetImagePath = RxString(assetImagePath);
    });
  }

  setProfileWithCroppedImage(croppedData) {
    // 선택된 기본 이미지 초기화
    selectedAssetImagePath.update((val) {
      selectedAssetImagePath = RxString("");
    });
    // 크롭된 이미지 업로드
    croppedImageData.update((val) {
      croppedImageData = Rx(croppedData);
    });
  }

  /// 이미지 업로드, 데이터 변환 함수(카메라)
  /// 이미지 가져와서 페이지 이동함.
  Future<void> getImageDataFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    final imageData = await pickedFile?.readAsBytes();
    if (imageData != null) {
      // 원본 선택한 이미지 데이터 -> CropPage
      Get.to(() => CropImagePage(
            imageData: imageData,
          ));
    }
  }

  /// 이미지 업로드, 데이터 변환 함수(앨범)
  /// 이미지 가져와서 페이지 이동함.
  Future<void> getImageDataFromAlbum() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final imageData = await pickedFile?.readAsBytes();
    if (imageData != null) {
      // 원본 선택한 이미지 데이터 -> CropPage
      Get.to(() => CropImagePage(
            imageData: imageData,
          ));
    }
  }
}

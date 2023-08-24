import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;

import 'package:flutter_svg/flutter_svg.dart';

class KlipImage extends StatefulWidget {
  const KlipImage({Key? key, required this.filePath, this.width, this.height})
      : super(key: key);

  final String filePath;
  final double? width;
  final double? height;

  @override
  State<KlipImage> createState() => _KlipImageState();
}

class _KlipImageState extends State<KlipImage> {
  Future? uiImage;

  @override
  Widget build(BuildContext context) {
    var width = widget.width?.toInt() ?? 50;
    var height = widget.height?.toInt() ?? 50;

    var item = widget.filePath;
    var imageInfo = vg.loadPicture(SvgAssetLoader(item), context);
    imageInfo.then((value) {
      if (uiImage == null) {
        setState(() {
          uiImage = value.picture
              .toImage(value.size.width.toInt(), value.size.height.toInt());
        });
      }
    }, onError: (error, stackTrace) {
      if (uiImage == null) {
        setState(() {
          uiImage = _getUiImage(item, width, height);
        });
      }
    });

    return FutureBuilder(
      future: uiImage,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return RawImage(
            image: snapshot.data,
            width: widget.width,
            height: widget.height,
          );
        } else {
          return SizedBox(
            width: widget.width,
            height: widget.height,
          );
        }
      },
    );
  }

  Future<ui.Image?> _getUiImage(
      String imageAssetPath, int height, int width) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
    image.Image? baseSizeImage =
        image.decodeImage(assetImageByteData.buffer.asUint8List());
    if (baseSizeImage == null) {
      return null;
    }
    image.Image resizeImage =
        image.copyResize(baseSizeImage, height: height, width: width);
    ui.Codec codec =
        await ui.instantiateImageCodec(image.encodePng(resizeImage));
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}

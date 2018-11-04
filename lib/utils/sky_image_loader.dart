import 'dart:ui' as sky;
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';


class ImageLoader {
  static AssetBundle getAssetBundle() {
    if (rootBundle != null) {
      return rootBundle;
    }
    NetworkAssetBundle networkAssetBundle = NetworkAssetBundle(Uri.directory(Uri.base.origin));
  }

  static Future<sky.Image> loadImage(String uri) async {
    AssetBundle assetBundle = getAssetBundle();
    ByteData imageBytes = await assetBundle.load(uri);
    sky.Image image = await decodeImageFromList(imageBytes.buffer.asUint8List());
    return image;
  }
}
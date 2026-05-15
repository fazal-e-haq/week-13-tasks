import 'dart:typed_data';

import 'package:image/image.dart' as img;

class ImageService {
  Future<Uint8List?> compressImage(Uint8List bytes) async {
    final decodeImg = img.decodeImage(bytes);
    if (decodeImg == null) return null;
    final resizeImg = img.copyResize(decodeImg, width: 1080);
    final compressedImg = img.encodeJpg(resizeImg, quality: 75);

    return Uint8List.fromList(compressedImg);
  }
}

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_optimization_app/Services/image_service.dart';

class CachedNetworkImagesWidget extends StatefulWidget {
  const CachedNetworkImagesWidget({super.key, required this.imageURL});
  final String imageURL;

  @override
  State<CachedNetworkImagesWidget> createState() =>
      _CachedNetworkImagesWidgetState();
}

class _CachedNetworkImagesWidgetState extends State<CachedNetworkImagesWidget> {
  Uint8List? thumbnilByte;
  @override
  void initState() {
    super.initState();
    generateThumbnil();
  }

  // Thumbnil for images
  Future<void> generateThumbnil() async {
    try {
      final networkImage = NetworkImage(widget.imageURL);
      final completer = Completer<ImageInfo>();
      networkImage
          .resolve(ImageConfiguration())
          .addListener(
            ImageStreamListener((image, synchronousCall) {
              completer.complete(image);
            }),
          );

      final imageInfo = await completer.future;
      final byteData = await imageInfo.image.toByteData(
        format: ImageByteFormat.png,
      );

      if (byteData == null) return;
      final bytes = byteData.buffer.asUint8List();

      final compress = await ImageService().compressImage(bytes);
      if (compress == null) return;
      if (mounted) {
        setState(() {
          thumbnilByte = compress;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(12),
      child: Stack(
        fit: .expand,
        children: [
          if (thumbnilByte != null)
            Image.memory(thumbnilByte!, fit: .cover, gaplessPlayback: true),

          CachedNetworkImage(
            imageUrl: widget.imageURL,
            fit: .cover,
            memCacheWidth: 400,
            maxWidthDiskCache: 600,
            fadeInDuration: Duration(milliseconds: 200),
            // if images take time to show then show progress
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator.adaptive()),
            // if image not found or has network issue then show error
            errorWidget: (context, url, error) {
              debugPrint(error.toString());
              return const Center(
                child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
              );
            },
          ),
        ],
      ),
    );

    ;
  }
}

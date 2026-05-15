import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Widgets/cached_network_images_widget.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  ScrollController controler = ScrollController();
  bool isloading = false;
  List<String> images = [];
  late List<String> newImg;
  int page = 0;

  // add random images from web and add in a list of images
  Future<void> loadImages() async {
    if (isloading) return;
    isloading = true;
    await Future.delayed(Duration(milliseconds: 500));

    newImg = List.generate(
      30,
      (index) => 'https://picsum.photos/500?random=$index',
    );
    setState(() {
      images.addAll(newImg as Iterable<String>);
      isloading = false;
      page++;
    });
  }

  @override
  void initState() {
    super.initState();
    loadImages();
    controler.addListener(() {
      if (controler.position.pixels >=
          controler.position.maxScrollExtent - 300) {
        loadImages();
      }
    });
  }

  // method for clearing cache of images
  Future<void> clearCache() async {
    await CachedNetworkImage.evictFromCache('');
    imageCache.clear();
    imageCache.clearLiveImages();
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Cache clear')));
    }
  }

  @override
  void dispose() {
    controler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Image Optimization'),

          actions: [
            IconButton(onPressed: clearCache, icon: Icon(Icons.delete)),
          ],
        ),
        body: Padding(
          padding: .symmetric(horizontal: 16, vertical: 8),
          // loading random images
          child: GridView.builder(
            itemCount: images.length,
            controller: controler,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return CachedNetworkImagesWidget(imageURL: images[index]);
            },
          ),
        ),
      ),
    );
  }
}

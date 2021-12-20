import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class ImageView extends StatelessWidget {
  final String imageURL;
  const ImageView({Key? key, required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Iconsax.folder_open),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Container(child: OptimizedCacheImage(imageUrl: imageURL)),
      ),
    );
  }
}

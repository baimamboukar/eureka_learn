import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
        child: Container(child: CachedNetworkImage(imageUrl: imageURL)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

Widget displayNetworkImage({
  required String imageUrl,
  bool isDetailScreen = false,
}) {
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
      if (isDetailScreen) {
        return Center(
          child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
        );
      } else {
        return Icon(Icons.broken_image, size: 50, color: Colors.grey);
      }
    },
  );
}

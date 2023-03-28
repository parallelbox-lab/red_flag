import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:red_flag/widgets/image_preview.dart';

class ImageSelector {
  File? imageFile;
  final _picker = ImagePicker();
/// Get image from gallery
 Future getFromGallery(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 0);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => ImagePreview(imagePreview: imageFile,)));
    }
  }
}
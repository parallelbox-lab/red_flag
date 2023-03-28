import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadImage{
  static Future<String> uploadImage({File? image}) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('images/img_' +
            timestamp.toString() +
            '.jpg');
   final _imageFile = File(image!.path);
    final uploadTask =
        storageReference.putFile(_imageFile);
    await uploadTask.then((p0) => {});
    return  await storageReference.getDownloadURL();       
  }
  static Future<String> uploadVideo({File? video}) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('video/vid_' +
            timestamp.toString() +
            '.mp4');
   final _imageFile = File(video!.path);
    final uploadTask =
        storageReference.putFile(_imageFile);
    await uploadTask.then((p0) => {});
    return  await storageReference.getDownloadURL();       
  }
}
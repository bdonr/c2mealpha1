import 'dart:io';

import 'package:c2mealpha1/classes/ObjectImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class ImageRepository {
  static final ImageRepository _singleton = ImageRepository._internal();
  final Future<UserCredential?> user =
      FirebaseAuth.instance.signInAnonymously();

  factory ImageRepository() {
    return _singleton;
  }

  ImageRepository._internal();

  uploadImage(File _image, DocumentReference reference, bool main) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('useruploads/big/' + _image.path);
    List<String> list = [];

    UploadTask uploadTask1 =
        storageReference.putFile(await _resizeImageHigh(_image));
    list.add(await _uploadFile(uploadTask1, storageReference));
    Reference storageReference2 = FirebaseStorage.instance
        .ref()
        .child('useruploads/medium/' + _image.path);
    UploadTask uploadTask2 =
        storageReference2.putFile(await _resizeImageMiddel(_image));
    list.add(await _uploadFile(uploadTask2, storageReference));
    Reference storageReference3 = FirebaseStorage.instance
        .ref()
        .child('useruploads/thumb/' + _image.path);
    UploadTask uploadTask3 =
        storageReference3.putFile(await _resizeImageThumbNail(_image));
    list.add(await _uploadFile(uploadTask3, storageReference));

    _saveImages(list, reference, main);
  }

  Future<String> _uploadFile(UploadTask task, Reference storage) async {
    return task.then((p0) {
      print('File Uploaded');
      String returnURL = "";
      return storage.getDownloadURL().then((fileURL) {
        print(fileURL);
        returnURL = fileURL;
        return returnURL;
      });
    });
  }

  void _saveImages(
      List<String> _images, DocumentReference ref, bool main) async {
    ref.collection("images").add({
      "thumb": _images[2],
      "middle": _images[1],
      "big": _images[0],
      "main": main,
      "parent": ref
    }).then((value) => value.update({"ref": value}));
    // ref.update({"images": FieldValue.arrayUnion([imageURL])});
  }

  Future<File> _resizeImageThumbNail(File file) {
    return FlutterNativeImage.compressImage(file.path,
        quality: 80, targetWidth: 50, targetHeight: 50);
  }

  Future<File> _resizeImageMiddel(File file) {
    return FlutterNativeImage.compressImage(file.path,
        quality: 80, targetWidth: 400, targetHeight: 400);
  }

  Future<File> _resizeImageHigh(File file) {
    return FlutterNativeImage.compressImage(file.path,
        quality: 100, targetWidth: 1900, targetHeight: 1024);
  }

  Stream<List<ObjectImage>> findImagesOf(DocumentReference reference) {
    return reference.collection("images").snapshots().map((event) => event.docs
        .map((e) => ObjectImage(e.get("big"), e.get("middle"), e.get("thumb"),
            e["ref"], e["parent"]))
        .toList());
  }

  Future<File> _changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickV extends StatefulWidget {
  const ImagePickV(this.notifyParent,{Key? key}) : super(key: key);

  final Function notifyParent;
  @override
  State<ImagePickV> createState() => _ImagePickVState();
}

class _ImagePickVState extends State<ImagePickV> {
  bool selectcam = false;
  bool selectgallery = false;

  Future getImage(bool gallery) async {
    List<File> _images = [];
    ImagePicker picker = ImagePicker();
    // Let user select photo from gallery
    XFile? pickedFile = null;
    if (gallery) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
        //_image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }

  List<File> _images = [];
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
            color: Colors.blue,
            child: const Text("Pick Image from Gallery",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: () {
              setState(() async {
                var pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                print(pickedFile?.path.toString());
                widget.notifyParent(File(pickedFile!.path));

              });
            }),
        MaterialButton(
            color: Colors.blue,
            child: const Text("Pick Image from Camera",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: ()  {
              setState(() async {
                var pickedFile = await picker.pickImage(source: ImageSource.camera);
                widget.notifyParent(File(pickedFile!.path));
              });
            }),
      ],
    );
  }
}

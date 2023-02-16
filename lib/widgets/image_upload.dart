import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageUpload extends StatefulWidget {
  final Function pickImage;
  const ImageUpload(this.pickImage, {super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _storeImg;

  Future<void> _addImg(ImageSource source) async {
    final imgFile =
        await ImagePicker().pickImage(source: source, maxHeight: 600);
    if (imgFile == null) return;
    setState(() {
      _storeImg = File(imgFile.path);
    });
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final imgFileName = path.basename(imgFile.path);
    final savedImg = await _storeImg!.copy('${appDir.path}/$imgFileName');
    widget.pickImage(savedImg);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 150,
          width: 150,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(border: Border.all()),
          child: _storeImg == null
              ? const Center(
                  child: Text(
                    'No Image Uploaded',
                  ),
                )
              : Image.file(_storeImg!, fit: BoxFit.cover),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt_rounded),
                label: const Text('Take Image'),
                onPressed: () => _addImg(ImageSource.camera),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt_rounded),
                label: const Text('Upload Image'),
                onPressed: () => _addImg(ImageSource.gallery),
              ),
            ],
          ),
        )
      ],
    );
  }
}

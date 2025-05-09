import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  final _picker = ImagePicker();

  Future<File?> compressImg(File img) async {
    try {
      final path = img.path;
      final dir = await getApplicationDocumentsDirectory();
      final targetPath = "${dir.absolute.path}/${path.split('/').last}";
      final compressImg =
          await FlutterImageCompress.compressAndGetFile(path, targetPath);
      return File(compressImg!.path);
    } catch (e) {
      debugPrint("Error $e");
      return null;
    }
  }

  Future<File?> pickOnly({bool isCameraSource = false}) async {
    final source = isCameraSource ? ImageSource.camera : ImageSource.gallery;
    final pickedImg = await _picker.pickImage(source: source);
    if (pickedImg != null) {
      final img = await compressImg(File(pickedImg.path));
      if (img != null) return img;
    }
    return null;
  }

  Future<File?> pick({required String name, isCameraSource = false}) async {
    final source = isCameraSource ? ImageSource.camera : ImageSource.gallery;
    final pickedImg = await _picker.pickImage(source: source);
    if (pickedImg != null) {
      final img = await compressImg(File(pickedImg.path));
      if (img != null) {
        await _save(name, img);
        return img;
      }
    }
    return null;
  }

  Future<void> _save(String name, File img) async {
    final path = (await getApplicationDocumentsDirectory()).path;
    final newPath = "$path/$name";
    await img.copy(newPath);
  }

  Future<File?> get(String name) async {
    final path = (await getApplicationDocumentsDirectory()).path;
    final imgPath = "$path/$name";
    final savedImg = File(imgPath);
    if (await savedImg.exists()) {
      return savedImg;
    }
    return null;
  }
}

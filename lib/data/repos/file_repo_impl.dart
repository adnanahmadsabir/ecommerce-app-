import 'dart:io';

import 'package:clothes_app/data/services/file_service.dart';
import 'package:clothes_app/domain/repos/file_repo.dart';
import 'package:flutter/cupertino.dart';

class FileRepoImpl implements FileRepo {
  final FileService fileService;
  FileRepoImpl(this.fileService);
  FileService get _service => fileService;

  @override
  Future<File?> pick(String name, {bool isCameraSource = false}) async {
    try {
      return await _service.pick(name: name, isCameraSource: isCameraSource);
    } catch (e) {
      debugPrint("Error $e");
      return null;
    }
  }

  @override
  Future<File?> get(String name) async {
    try {
      return await _service.get(name);
    } catch (e) {
      debugPrint("Error $e");
      return null;
    }
  }
}

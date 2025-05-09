import 'dart:io';

import 'package:clothes_app/domain/repos/file_repo.dart';
import 'package:flutter/material.dart';

class FileProvider extends ChangeNotifier {
  final FileRepo fileRepo;

  FileProvider(this.fileRepo) {
    _loadSavedImg();
  }

  bool _isLoading = false;
  File? _img;
  final _name = "profile_img.jpg";

  FileRepo get _repo => fileRepo;
  File? get getImage => _img;
  bool get isLoading => _isLoading;

  void _toggleLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> pickImage({bool isCameraSource = false}) async {
    _toggleLoading(true);
    final img = await _repo.pick(_name, isCameraSource: isCameraSource);
    _toggleLoading(false);
    if (img != null) {
      _img = File(img.path);
      notifyListeners();
    }
  }

  Future<void> _loadSavedImg() async {
    _img = await _repo.get(_name);
    notifyListeners();
  }
}

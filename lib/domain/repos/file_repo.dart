import 'dart:io';

abstract class FileRepo {
  Future<File?> pick(String name, {bool isCameraSource = false});
  Future<File?> get(String name);
}

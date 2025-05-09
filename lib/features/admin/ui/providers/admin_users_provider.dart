import 'dart:io';

import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/data/services/file_service.dart';
import 'package:clothes_app/domain/entities/user.dart';
import 'package:clothes_app/features/admin/domain/usecases/admin_users_use_case.dart';
import 'package:clothes_app/features/admin/ui/screens/upload_item_screen.dart';
import 'package:flutter/cupertino.dart';

class AdminUsersProvider extends ChangeNotifier {
  final AdminUsersUseCase adminUsersUseCase;
  AdminUsersProvider(this.adminUsersUseCase);

  bool _isLoading = false;
  final _fileService = FileService();
  int _totalUsers = 0;
  double _kbs = 0.0;
  File? _image;

  bool get isLoading => _isLoading;
  int get totalUsers => _totalUsers;
  double get kbs => _kbs;
  File? get image => _image;

  void _toggleLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<List<User?>> get() async {
    final users = await adminUsersUseCase.get();
    _totalUsers = users.length;
    return users;
  }

  /// methods for picking image
  Future<void> selectImage(
      {required BuildContext context, bool isCameraSource = false}) async {
    _toggleLoading(true);
    final pickedImg =
        await _fileService.pickOnly(isCameraSource: isCameraSource);
    if (pickedImg != null && context.mounted) {
      final bytes = await pickedImg.readAsBytes();
      final kb = bytes.length / 1024;
      _image = pickedImg;
      _kbs = kb;

      if (context.mounted) {
        Navigator.pop(context);
        Utils.getPage(context, UploadItemScreen(image: image!, kbs: kbs));
      }
    }
    _toggleLoading(false);
  }
}

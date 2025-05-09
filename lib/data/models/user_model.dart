import 'package:clothes_app/domain/entities/user.dart';

class UserModel extends User {
  UserModel({super.id, super.name, super.email, super.password});
  static const _idKey = "id",
      _nameKey = "name",
      _emailKey = "email",
      _passwordKey = "password";

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json[_idKey],
        name: json[_nameKey] as String? ?? "",
        email: json[_emailKey] as String? ?? "",
        password: json[_passwordKey] as String? ?? "");
  }

  Map<String, dynamic> toJson() => {
        _idKey: id ?? "",
        _nameKey: name ?? "",
        _emailKey: email ?? "",
        _passwordKey: password ?? ""
      };
}

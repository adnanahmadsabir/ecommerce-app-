import 'package:clothes_app/core/label_keys.dart';
import 'package:clothes_app/core/my_reg_exp.dart';

class Validators {
  static String? checkName(String? text) {
    return text!.length < 3 ? "Item name is at least 3 char long!" : null;
  }

  static String? checkEmail(String? text) {
    // final isTrue = MyRegExp.email.hasMatch(text!);
    return text!.isNotEmpty ? null : validEmailReqKey;
  }

  static String? checkPassword(String? text) {
    // final isValid = MyRegExp.password.hasMatch(text!);
    return text!.isNotEmpty ? null : validPasswordReqKey;
  }

  static String? checkRatings(String? text) {
    bool isValid = MyRegExp.rating.hasMatch(text!);
    return isValid ? null : "Rating is b/w [0.0 - 5.0]!";
  }

  static String? checkPrice(String? text) {
    return text!.isEmpty ? "Enter price!" : null;
  }

  static String? checkTags(String? text) {
    return text!.length < 7 ? "At least 7 chars!" : null;
  }

  static String? checkDesc(String? text) {
    return text!.length < 15 ? "Description is at least 15 chars!" : null;
  }

  static String? checkSizes(String? text) {
    return text!.isEmpty ? enterItemSizesKey : null;
  }
}

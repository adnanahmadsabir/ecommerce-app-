import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    this.onBackBtnPressed,
    required this.autoFocus,
    required this.onChanged,
    this.searchCtrl,
    this.validator,
    this.onTap,
  });

  final TextEditingController? searchCtrl;
  final FormFieldValidator<String?>? validator;
  final VoidCallback? onTap;
  final void Function(String?) onChanged;
  final VoidCallback? onBackBtnPressed;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
        autofocus: autoFocus,
        autocorrect: true,
        decoration: InputDecoration(
            hintText: 'Search...',
            suffixIcon: IconButton(
                onPressed: onBackBtnPressed,
                icon: const Icon(CupertinoIcons.xmark)),
            prefixIcon: const Icon(
              Icons.search,
            )),
        onTap: onTap,
        onChanged: onChanged);
  }
}

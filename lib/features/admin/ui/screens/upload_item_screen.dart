import 'dart:io';

import 'package:clothes_app/core/constants.dart';
import 'package:clothes_app/core/extensions.dart';
import 'package:clothes_app/core/label_keys.dart';
import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/core/validators.dart';
import 'package:clothes_app/features/admin/ui/providers/upload_item_provider.dart';
import 'package:clothes_app/features/admin/ui/screens/admin_home_screen.dart';
import 'package:clothes_app/ui/widgets/my_appbar.dart';
import 'package:clothes_app/ui/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UploadItemScreen extends StatelessWidget {
  final File? image;
  final double kbs;
  UploadItemScreen({super.key, required this.image, this.kbs = 0.0});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<UploadItemProvider>();
    return Scaffold(
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(image!))),
              ),
              const SizedBox(height: 10),
              Text(
                "Size: ${kbs.toString().fixed(maxLength: 6)} KB",
              ),
              Container(
                  padding: padding20,
                  child: Form(
                    key: _formKey,
                    child: Column(spacing: 14, children: [
                      MyTextField(
                          prefixIcon: const Icon(FontAwesomeIcons.t),
                          hintText: itemNameKey,
                          validator: (text) => Validators.checkName(text),
                          controller: provider.nameCtrl),
                      MyTextField(
                          prefixIcon: const Icon(Icons.rate_review),
                          hintText: itemRatingKey,
                          keyboardType: TextInputType.number,
                          validator: (text) => Validators.checkRatings(text),
                          controller: provider.ratingsCtrl),
                      MyTextField(
                          prefixIcon: const Icon(Icons.tag),
                          hintText: itemTagsKey,
                          validator: (text) => Validators.checkTags(text),
                          controller: provider.tagsCtrl),
                      MyTextField(
                          prefixIcon: const Icon(Icons.price_change_rounded),
                          hintText: itemPriceKey,
                          keyboardType: TextInputType.number,
                          validator: (text) => Validators.checkPrice(text),
                          controller: provider.priceCtrl),
                      MyTextField(
                          prefixIcon: const Icon(Icons.format_size),
                          hintText: itemSizesKey,
                          validator: (text) => Validators.checkSizes(text),
                          controller: provider.sizesCtrl),
                      MyTextField(
                          prefixIcon: const Icon(Icons.color_lens_sharp),
                          hintText: itemColorsKey,
                          validator: (value) {
                            return provider.colorsCtrl.text.isEmpty
                                ? enterItemColorsKey
                                : null;
                          },
                          controller: provider.colorsCtrl),
                      MyTextField(
                          prefixIcon: const Icon(Icons.description),
                          hintText: itemDescKey,
                          validator: (text) => Validators.checkDesc(text),
                          controller: provider.descCtrl),
                      _buildUploadButton()
                    ]),
                  ))
            ],
          ),
        ));
  }

  AppBar _appBar(BuildContext context) => myAppbar(
      context: context,
      title: "Upload Form",
      centerTitle: true,
      isLeading: false,
      leading: IconButton(
          onPressed: () => Utils.getPage(context, AdminHomeScreen()),
          icon: const Icon(Icons.clear)));

  Widget _buildUploadButton() => Selector<UploadItemProvider, bool>(
      selector: (_, provider) => provider.isUploading,
      builder: (context, isUploading, __) => isUploading
          ? const LinearProgressIndicator()
          : FilledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<UploadItemProvider>()
                      .uploadItemData(context, imagePath: image!.path);
                }
              },
              child: const Text("Upload Now")));
}

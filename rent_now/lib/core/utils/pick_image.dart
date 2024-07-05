import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(ImageSource source) async {
  try {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );
    if (image == null) return null;
    return File(image.path);
  } catch (e) {
    return null;
  }
}

import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> PickImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      File finalImage = File(image.path);
      return finalImage;
    }
    return null;
  } catch (e) {
    return null;
  }
}

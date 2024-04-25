import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<String> chooseFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);

    return file.path;
  } else {
    return "";
  }
}

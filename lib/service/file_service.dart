import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileManager {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/checker.state');
  }

  Future<String> readChecker() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      writeChecker('');
      return '';
    }
  }

  Future<File> writeChecker(String state) async {
    final file = await _localFile;
    return file.writeAsString(state);
  }
}


import 'dart:io';

import 'package:md5_plugin/md5_plugin.dart';

extension FileUtil on File {

  String get filename => path.split('/').last;

  Future<String> calculateChecksum() async {
    try {
      final String checksum = await Md5Plugin.getMD5WithPath(path);
      return checksum;
    } catch (exception) {
      print('Unable to evaluate the MD5 sum :$exception');
    }
    return '';
  }
}
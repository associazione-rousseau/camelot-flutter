
import 'dart:io';

extension FileUtil on File {
  String get filename => path.split('/').last;
  String get checksum => '';
}
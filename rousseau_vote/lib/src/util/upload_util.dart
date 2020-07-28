import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';

Future<String> uploadFile(File file, String fileName) async {
  final Dio dio = getIt<Dio>();
  
  FormData formData = FormData.fromMap(<String,dynamic>{
    'file': await MultipartFile.fromFile(file.path, filename:fileName),
  });
  
  //TODO missing url
  
  dynamic response = await dio.post<dynamic>("/urlToUploadPath", data: formData);
  return response.data['id'];
}
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/store/token_store.dart';

Future<String> uploadFile(File file, String fileName) async {
  final Dio dio = getIt<Dio>();
  
  final FormData formData = FormData.fromMap(<String,dynamic>{
    'file': await MultipartFile.fromFile(file.path, filename:fileName),
  });

  final TokenStore tokenStore = getIt<TokenStore>();
  final String accessToken = await tokenStore.getAccessToken();
    
  dynamic response = await dio.post<dynamic>(
    FILE_UPLOAD_URL_PRODUCTION, 
    options: Options(
      headers: <String,String>{
        'Authorization': 'Bearer $accessToken'
      }
    ),
    data: formData
    );
  return response.data['id'];
}
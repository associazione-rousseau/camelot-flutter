import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/network/response/direct_upload.dart';
import 'package:rousseau_vote/src/store/token_store.dart';
import 'package:crypto/crypto.dart';


Future<String> uploadFile(File file, String fileName) async {
  final Dio dio = getIt<Dio>();

  FormData formData = FormData.fromMap(<String,dynamic>{
    'file': await MultipartFile.fromFile(file.path, filename:fileName),
  });
  

  final int byteSize = await file.length();
  final Uint8List bytes = await file.readAsBytes();
  final String checksum = sha256.convert(bytes).toString();


  //1. CREATE BLOB WITH FILE INFO
  final Map<String,dynamic> blob = <String,dynamic>{
    'blob': <String,dynamic>{
      'byte_size': byteSize,
      'checksum': checksum,
      'content_type': 'image/png',
      'filename': fileName
    }
  };

  final TokenStore tokenStore = getIt<TokenStore>();
  final String accessToken = await tokenStore.getAccessToken();
  
  //2. GET S3 UPLOAD URL FROM ROUSSEAU API
  final Response<dynamic> response = await dio.post<dynamic>(
    FILE_UPLOAD_URL_PRODUCTION, 
    options: Options(
      headers: <String,String>{
        'Authorization': 'Bearer $accessToken'
      }
    ),
    data: blob
  );

  final DirectUpload directUpload = DirectUpload.fromJson(response.data['direct_upload']);
    
  if(directUpload == null || directUpload.url.isEmpty) return null;
  

  //3. UPLOAD FILE TO S3
  final Response<dynamic> fileUploadResponse = await dio.put<dynamic>(
    directUpload.url, 
    options: Options(
      headers: directUpload.headers
    ),
    data: formData,
    onSendProgress: (int sent, int total) {
      // do something
      print('sent ' + sent.toString() + '/' + total.toString());
    },
  ).catchError((Object e) {
    throw Exception(e);
  });
  print(fileUploadResponse);

}
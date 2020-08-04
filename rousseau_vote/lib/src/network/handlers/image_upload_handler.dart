
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/network/request/direct_upload_request_blob.dart';
import 'package:rousseau_vote/src/network/response/direct_uploads_response.dart';
import 'package:rousseau_vote/src/network/restclients/direct_uploads_rest_client.dart';
import 'package:rousseau_vote/src/util/file_util.dart';

@singleton
class ImageUploadHandler {

  ImageUploadHandler() : _restClient = DirectUploadsRestClient(Dio());

  final DirectUploadsRestClient _restClient;

  Future<bool> uploadImage(PickedFile pickedFile) async {
    final File file = File(pickedFile.path);
    final String checksum = await file.calculateChecksum();
    final DirectUploadRequestBlob blob =
      DirectUploadRequestBlob(byteSize: file.lengthSync(), checksum: checksum, filename: file.filename, contentType: 'image/jpeg');
    final DirectUploadsResponse response = await _restClient.post(blob);

    final Map<String, String> headers = <String, String>{
      'content-type': response.directUpload.headers.contentType,
      'content-md5': response.directUpload.headers.contentMd5,
    };
    final Uint8List bytes = await pickedFile.readAsBytes();
    final http.Response s3Response = await http.put(response.directUpload.url, body: bytes, headers: headers);

    return s3Response.statusCode == 200;
  }
}

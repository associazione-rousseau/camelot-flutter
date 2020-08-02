
import 'dart:io';

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

  Future<DirectUploadsResponse> uploadImage(PickedFile pickedFile) async {
    final File file = File(pickedFile.path);
    final DirectUploadRequestBlob blob =
      DirectUploadRequestBlob(byteSize: file.lengthSync(), checksum: file.checksum, filename: file.filename, contentType: 'image/png');
    final DirectUploadsResponse response = await _restClient.post(blob);
    return response;
  }
}
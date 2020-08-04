import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/handlers/image_upload_handler.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class VerifyIdentityScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/verify_identity';

  @override
  Widget build(BuildContext context) {
    final String buttonText =
        RousseauLocalizations.getText(context, 'identity-verification-load-id');
    return RousseauLoggedScaffold(
      appBar: RousseauAppBar(),
      showDrawer: false,
      body: RoundedButton(
        text: buttonText,
        onPressed: () {
          _openCamera(context);
        },
      ),
    );
  }

  void _openCamera(BuildContext context) {
    openCamera().then(
        (PickedFile pickedFile) => _onImagePicked(context, pickedFile),
        onError: (dynamic error) => _onImagePickingError(context));
  }

  void _onImagePicked(BuildContext context, PickedFile pickedFile) {
    final ImageUploadHandler handler = getIt<ImageUploadHandler>();
    handler.uploadImage(pickedFile).then((bool success) {
      if (!success) {
        print("SUCCESS but error");
        _onImagePickingError(context);
      }
      print("SUCCESS!!!");
    }).catchError((dynamic error) {
      print(error);
      _onImagePickingError(context);
    });
  }

  void _onImagePickingError(BuildContext context) {
    final SnackBarAction action =
        createSnackBarAction(context, 'retry', () => _openCamera(context));
    showSimpleSnackbar(context,
        textKey: 'identity-verification-load-error', action: action);
  }
}

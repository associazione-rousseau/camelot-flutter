import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/handlers/verification_request_handler.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
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
      appBar: AppBar(title: Text(RousseauLocalizations.getText(context, 'drawer-verify-identity')),),
      showDrawer: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              RousseauLocalizations.getText(context, 'verify-identity-title'),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const VerticalSpace(10),
            Text(
                RousseauLocalizations.getText(context, 'verify-identity-subtitle'),
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const VerticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset('assets/images/identity_verification/italian_id.png'),
            ),
            const VerticalSpace(10),
            Text(
              RousseauLocalizations.getText(context, 'verify-identity-warning').toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const VerticalSpace(40),
            RoundedButton(
              wrapContent: true,
              text: buttonText,
              onPressed: () {
                _openCamera(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openCamera(BuildContext context) {
    openCamera().then(
        (PickedFile pickedFile) => _onImagePicked(context, pickedFile),
        onError: (dynamic error) => _onImagePickingError(context));
  }

  void _onImagePicked(BuildContext context, PickedFile pickedFile) {
    final VerificationRequestHandler handler = getIt<VerificationRequestHandler>();
    handler.sendVerificationRequest(pickedFile).then((bool success) {
      if (!success) {
        _onImagePickingError(context);
      }
      _onRequestSuccess(context);
    }).catchError((dynamic error) {
      _onImagePickingError(context);
    });
  }

  void _onRequestSuccess(BuildContext context) {
    print("SUCCESS!");
  }

  void _onImagePickingError(BuildContext context) {
    final SnackBarAction action =
        createSnackBarAction(context, 'retry', () => _openCamera(context));
    showSimpleSnackbar(context,
        textKey: 'identity-verification-load-error', action: action);
  }
}

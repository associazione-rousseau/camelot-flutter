import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/handlers/verification_request_handler.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/util/widget/vertical_space.dart';
import 'package:rousseau_vote/src/widgets/dialog/loading_dialog.dart';
import 'package:rousseau_vote/src/widgets/done_dialog.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/widgets/rousseau_app_bar.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class VerifyIdentityScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/verify_identity';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final String buttonText =
        RousseauLocalizations.getText(context, 'identity-verification-load-id');
    return RousseauLoggedScaffold(
      appBar: AppBar(
        title: Text(
            RousseauLocalizations.getText(context, 'drawer-verify-identity')),
      ),
      showDrawer: false,
      body: Scaffold(
        key: _scaffoldKey,
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
                RousseauLocalizations.getText(
                    context, 'verify-identity-subtitle'),
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const VerticalSpace(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GestureDetector(
                    onTap: () {
                      _openCamera(context);
                    },
                    child: Image.asset(
                        'assets/images/identity_verification/italian_id.png')),
              ),
              const VerticalSpace(10),
              Text(
                RousseauLocalizations.getText(context, 'verify-identity-warning')
                    .toUpperCase(),
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
      ),
    );
  }

  void _openCamera(BuildContext context) {
    openCamera().then(
        (PickedFile pickedFile) => _onImagePicked(context, pickedFile),
        onError: (dynamic error) => _onImagePickingError(context));
  }

  void _onImagePicked(BuildContext context, PickedFile pickedFile) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(
                RousseauLocalizations.getText(
                    context, 'verify-identity-dialog-title'),
                style: const TextStyle(color: PRIMARY_RED)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const VerticalSpace(20),
                Image.file(File(pickedFile.path)),
                const VerticalSpace(20),
                Text(
                  RousseauLocalizations.getText(
                      context, 'verify-identity-dialog-message'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(RousseauLocalizations.getText(context, 'cancel')),
                onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              ),
              FlatButton(
                child: Text(
                  RousseauLocalizations.getText(context, 'send'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => _onConfirm(context, pickedFile),
              )
            ]);
      },
    );
  }

  void _onConfirm(BuildContext context, PickedFile pickedFile) {
    Navigator.of(context, rootNavigator: true).pop();

    final VerificationRequestHandler handler =
    getIt<VerificationRequestHandler>();

    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          handler.sendVerificationRequest(pickedFile).then((bool success) {
            Navigator.of(dialogContext, rootNavigator: true).pop();
            if (!success) {
              _onImagePickingError(dialogContext);
              return;
            }
            _onRequestSuccess(dialogContext);
          }).catchError((dynamic error) {
            Navigator.of(dialogContext, rootNavigator: true).pop();
            _onImagePickingError(dialogContext);
          });
          return const LoadingDialog(titleKey: 'vote-confirm-sending',);
        });
  }

  void _onRequestSuccess(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          final Widget body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const VerticalSpace(30),
              const Icon(
                Icons.done_all,
                color: Colors.green,
              ),
              Text(
                RousseauLocalizations.getText(context, 'verify-identity-send-success'),
                textAlign: TextAlign.center,
              )
            ],
          );
          final List<FlatButton> buttons = <FlatButton>[
            FlatButton(
                child: Text(
                  RousseauLocalizations.getText(context, 'back-home'),
                ),
                onPressed: () {
                  Navigator.of(dialogContext, rootNavigator: true).pop();
                  Navigator.of(dialogContext, rootNavigator: true).pop();
                }
            )
          ];

          return AlertDialog(
            content: SingleChildScrollView(
              child: body,
            ),
            actions: buttons,
          );
        });
  }

  void _onImagePickingError(BuildContext context) {
    final SnackBarAction action =
        createSnackBarAction(context, 'retry', () => _openCamera(context));
    showSimpleSnackbar(_scaffoldKey.currentContext,
        textKey: 'identity-verification-load-error', action: action);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/network/handlers/mi_fido_network_handler.dart';
import 'package:rousseau_vote/src/util/dialog_util.dart';

class MiFidoIconWidget extends StatefulWidget {
  const MiFidoIconWidget({this.userProfile, this.size = 24});

  final UserProfile userProfile;
  final double size;

  @override
  _MiFidoIconWidgetState createState() => _MiFidoIconWidgetState();
}

class _MiFidoIconWidgetState extends State<MiFidoIconWidget> {
  bool _subscribed;

  @override
  void initState() {
    super.initState();
    _subscribed = widget.userProfile.isSubscripted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => _onTap(context),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: _subscribed ? PRIMARY_RED : DISABLED_GREY,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.done_all,
          color: Colors.white,
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    _subscribed ? _onUnsubscribe(context) : _onSubscribe(context);
  }

  void _onSubscribe(BuildContext buildContext) {
    showAlertDialog(context,
        barrierDismissible: true,
        titleKey: 'confirm-mi-fido-title',
        messageKey: 'confirm-mi-fido-message',
        buttonKey1: 'back',
        buttonKey2: 'confirm',
        buttonAction1: () => Navigator.pop(context),
        buttonAction2: () {
          Navigator.pop(context);
          getIt<MiFidoNetworkHandler>().subscribe(widget.userProfile);
          setState(() {
            _subscribed = true;
          });
        });
  }

  void _onUnsubscribe(BuildContext buildContext) {
    getIt<MiFidoNetworkHandler>().unsubscribe(widget.userProfile);
    setState(() {
      _subscribed = false;
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/core/conditional_widget.dart';
import 'package:rousseau_vote/src/widgets/dialog/loading_dialog.dart';
import 'package:rousseau_vote/src/widgets/dialog/thank_you_dialog.dart';
import 'package:rousseau_vote/src/widgets/feedback/send_feedback_arguments.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class SendFeedbackScreen extends StatefulWidget {
  const SendFeedbackScreen({@required this.arguments});

  static const String ROUTE_NAME = '/send_feedback';

  final SendFeedbackArguments arguments;

  @override
  _SendFeedbackScreenState createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  final TextEditingController textController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  bool actionEnabled;

  @override
  void initState() {
    super.initState();
    actionEnabled = false;
    textController.addListener(() {
      if (actionEnabled && textController.text.isEmpty) {
        setState(() {
          actionEnabled = false;
        });
      } else if (!actionEnabled && textController.text.isNotEmpty) {
        setState(() {
          actionEnabled = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
        appBar: AppBar(
          title:
              Text(RousseauLocalizations.getText(context, 'drawer-feedback')),
        ),
        scaffoldKey: _scaffoldState,
        showDrawer: false,
        floatingActionButton: ConditionalWidget(
          condition: actionEnabled,
          child: FloatingActionButton.extended(
            label: Text(RousseauLocalizations.getText(context, 'send')),
            icon: const Icon(Icons.send),
            onPressed: () => _onSendTapped(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: textController,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
                hintText: RousseauLocalizations.of(context)
                    .text('feedback-write-here')),
            maxLines: 10,
            minLines: 1,
            keyboardType: TextInputType.multiline,
          ),
        ));
  }

  void _onSendTapped(BuildContext context) {
    final UserNetworkHandler userNetworkHandler = getIt<UserNetworkHandler>();
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          userNetworkHandler
              .feedbackSubmit(widget.arguments.category, textController.text)
              .then((_) {
            _onSendSuccess(dialogContext);
          }).catchError((Object error) {
            _onSendError(context, dialogContext, error);
          });

          return const LoadingDialog(
            titleKey: 'vote-confirm-sending',
          );
        });
  }

  void _onSendSuccess(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) =>
            const ThankYouDialog(textKey: 'feedback-thanks'));
  }

  void _onSendError(
      BuildContext context, BuildContext dialogContext, Object error) {
    Navigator.pop(context);
    showRousseauSnackbar(context, _scaffoldState, 'error-generic');
  }
}

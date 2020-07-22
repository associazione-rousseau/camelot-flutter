import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/network/response/user/feedback_submit_response.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';

class FeedbackScreen extends StatefulWidget{
  static const String ROUTE_NAME = '/feedback';

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final GlobalKey _scaffoldState = GlobalKey<ScaffoldState>();
  String category = 'bug_report';
  static List<String> categories = <String>['bug_report', 'feature_improvement', 'new_feature', 'feedback'];
  final TextEditingController textController = TextEditingController();
  final UserNetworkHandler _userNetworkHandler = getIt<UserNetworkHandler>();

  @override initState(){
    super.initState();
    textController.addListener((){
      //enable/disable button depending on textfield text
      setState(() {});
    });
  }

  @override build(BuildContext context){
    final String title = RousseauLocalizations.getText(context, 'drawer-feedback');

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              RousseauLocalizations.getText(context, 'category'),
              style:TextStyle(
                
                // decoration: TextDecoration.overline
              )
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: category,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black
              ),
              onChanged: (String newValue) {
                setState(() {
                  category = newValue;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(RousseauLocalizations.getText(context, 'feedback-' + value)),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                RousseauLocalizations.getText(context, 'feedback')
              ),
            ),
            Expanded(
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: RousseauLocalizations.of(context).text('feedback-write-here')
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
            RoundedButton(
              text: RousseauLocalizations.of(context).text('send').toUpperCase(),
              onPressed: textController.text.isEmpty ? null : () => sendFeedback(),
            )
          ],
        ),
      )
    );
  }
  void sendFeedback() async{
    FeedbackSubmitResponse response = await _userNetworkHandler.feedbackSubmit(category, textController.text);
    if(response == null || response.errors != null){
      showRousseauSnackbar(context, _scaffoldState, 'error-generic');
      return;
    }
    showRousseauSnackbar(context, _scaffoldState, 'object-created');
    textController.text = '';
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/network/response/user/user_response.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/screens/login_screen.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';

class DeleteAccountActionScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/delete_account_action';
  
  @override
  _DeleteAccountActionScreenState createState() => _DeleteAccountActionScreenState();
}

class _DeleteAccountActionScreenState extends State<DeleteAccountActionScreen> {
  _DeleteAccountActionScreenState();
  List<bool> bools = [false,false,false,false,false,false];
  List<String> reasons = <String>['unsubscribe-political','unsubscribe-too-much-communication','unsubscribe-technical-issues','unsubscribe-no-support','unsubscribe-bad-content','unsubscribe-other'];
  String selectedReason;
  TextEditingController customReasonController = TextEditingController();
  final UserNetworkHandler _userNetworkHandler = getIt<UserNetworkHandler>();
  final GlobalKey _scaffoldState = GlobalKey<ScaffoldState>();

  @override Widget build(BuildContext context){
    final String title = RousseauLocalizations.of(context).text('edit-account-delete');
    
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              RousseauLocalizations.of(context).text('unsubscribe-reason'),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bools.length,
              itemBuilder: (context, int index) {
                final String text = RousseauLocalizations.of(context).text(reasons[index]);
                return Column(
                  children: <Widget>[
                    CheckboxListTile(
                      value: bools[index],
                      title: Text(
                        text,
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      onChanged: (bool value){
                        setState(() {
                          bools = <bool>[false,false,false,false,false,false];
                          bools[index] = value;
                          selectedReason = value == true ? text : null;
                          customReasonController.text = '';
                        });
                      }
                    ),
                    (reasons[index] == 'unsubscribe-other' && bools[index] == true) ?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextField(
                        controller: customReasonController,
                        decoration: InputDecoration(
                          hintText: RousseauLocalizations.of(context).text('unsubscribe-reason-custom')
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        ),
                    ) 
                    : Container(),
                  ],
                );
              }
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all( 15),
              child: RoundedButton(
                text: RousseauLocalizations.of(context).text('unsubscribe-action'),
                onPressed: selectedReason != null ? () =>  deleteAccount() : null,
              ),
            ),
          ),
        ],
      )
    );
  }

  Future<void> deleteAccount() async{
    if(bools[bools.length-1] == true && customReasonController.text.isNotEmpty){
      selectedReason += ': ' + customReasonController.text;
    }
    UserResponse response = await _userNetworkHandler.deleteUser(selectedReason);
    if(response != null && response.userDelete != null && response.userDelete.errors == null){
      Provider.of<Login>(context, listen: false).logout();
      openRoute(context, LoginScreen.ROUTE_NAME, replace: true);
    }
    else{
      showRousseauSnackbar(context, _scaffoldState, 'error-network');
    }
  }
}
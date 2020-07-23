import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_mutations.dart';
import 'package:rousseau_vote/src/widgets/rounded_text_field.dart';

class LoginInfoWidget extends StatefulWidget{
  LoginInfoWidget(this.userOriginalEmail,this.userOriginalPhoneNumber, this._scaffoldState){
    _emailController = TextEditingController(text: userOriginalEmail);
    _phoneNumberController = TextEditingController(text: userOriginalPhoneNumber);
  }
  String userOriginalEmail;
  String userOriginalPhoneNumber;
  TextEditingController _emailController;
  TextEditingController _phoneNumberController;
  GlobalKey<ScaffoldState> _scaffoldState;

  @override
  _LoginInfoWidgetState createState() => _LoginInfoWidgetState();
}

class _LoginInfoWidgetState extends State<LoginInfoWidget> {

  @override
  void initState() {
    //enable/disable button
    widget._emailController.addListener(() {
      setState(() {});
    });
    widget._phoneNumberController.addListener(() {
      setState(() {});
    });
  }

  @override 
  build(BuildContext context){
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal:15, vertical:10),
            children: <Widget>[
              RoundedTextField(controller: widget._emailController, labelText: 'email', enabled: true),
              RoundedTextField(controller: widget._phoneNumberController, labelText: 'phone-number', enabled: true),
            ],
          ),
        ),
        GraphQLProvider(
          client: getIt<ValueNotifier<GraphQLClient>>(),
          child: Mutation(
            options: MutationOptions(
              documentNode: gql(userAccessDataUpdate),
              update: (Cache cache, QueryResult result) {
                String message;

                if (result.hasException) {
                  print('exception');
                }

                final Map<String, Object> user = (result.data
                    as Map<String, Object>)['user'] as Map<String, Object>;
                final LazyCacheMap map = user.values.first;
                final List<Object> errors = map.values.first;
                message = errors == null || errors.isEmpty
                    ? 'info-saved'
                    : 'error-generic';
                if(errors == null){
                  setState(() {
                    widget.userOriginalEmail = widget._emailController.text;
                    widget.userOriginalPhoneNumber = widget._phoneNumberController.text;
                  });
                }
                showRousseauSnackbar(context, widget._scaffoldState, message);
              },
            ),
            builder: (RunMutation runMutation, QueryResult result) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: RoundedButton(
                  text: RousseauLocalizations.of(context).text('save'),
                  loading: result.loading,
                  onPressed: (widget._emailController.text == widget.userOriginalEmail && widget._phoneNumberController.text == widget.userOriginalPhoneNumber) ?
                    null : (){
                    Map<String, dynamic> variables =
                        HashMap<String, dynamic>();
                    variables.putIfAbsent(
                        'user',
                        () => {
                              'phoneNumber': widget._phoneNumberController.text,
                              'email': widget._emailController.text
                            });
                    return runMutation(
                      variables,
                    );
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
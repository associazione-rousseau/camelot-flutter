import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_mutations.dart';

class VoteDialog extends StatelessWidget {

  const VoteDialog(this._options, this._pollId, this._error, this._done);

  final String _pollId;
  final List<Option> _options;
  final Function _error;
  final Function _done;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> variables = HashMap<String, dynamic>();
    variables.putIfAbsent('pollId', () => _pollId);
    variables.putIfAbsent('optionIds', () => _options.map((Option o) => o.id).toList());
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      title: Text(
        RousseauLocalizations.getText(context, 'vote-confirm'),
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: getContent(context),
      elevation: 5,
      actions: <Widget>[
        FlatButton(
          child: Text(
            RousseauLocalizations.getText(context, 'cancel'),
            style: const TextStyle(fontSize: 18),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop()
        ),
        GraphQLProvider(
          client: getIt<ValueNotifier<GraphQLClient>>(),
          child: Mutation(
            options: MutationOptions(
              documentNode: gql(pollAnswerSubmit),
              update: (Cache cache, QueryResult result) {
                if (result.hasException) {
                  _error(context);
                } 
                final Map<String, Object> user = (result.data as Map<String, Object>)['user'] as Map<String, Object>;
                final LazyCacheMap map = user.values.first;
                final List<Object> errors = map.values.first;
                errors == null || errors.isEmpty ? _done(context) : _error(context);
              },
            ),
            builder: (RunMutation runMutation, QueryResult result) {
              return FlatButton(
                child: Text(
                  RousseauLocalizations.getText(context, 'confirm'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                onPressed: () => runMutation(variables)
              );
            },
          ),
        ),
        Container()
      ],
    );
  }

  Widget getContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(RousseauLocalizations.getText(
          context, 
          _options.length == 1 ? 'vote-content-1s' : 'vote-content-1p'
        )),
        const SizedBox(height: 10),
        for(Option option in _options) Row(children: <Widget>[
          const SizedBox(width: 10),
          Icon(Icons.radio_button_checked),
          const SizedBox(width: 10),
          Text(option.text, style: const TextStyle(fontWeight: FontWeight.bold))
        ]),
        const SizedBox(height: 10),
        Text(RousseauLocalizations.getText(context, 'vote-content-2'))
      ],
    );
  }

}
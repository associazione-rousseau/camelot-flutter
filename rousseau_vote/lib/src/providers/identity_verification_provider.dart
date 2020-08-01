
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';

class IdentityVerificationProvider extends ChangeNotifier {

  IdentityVerificationProvider() {
    final QueryOptions options = QueryOptions();
    client.query(options);
  }

  final GraphQLClient client = getIt<GraphQLClient>();
}
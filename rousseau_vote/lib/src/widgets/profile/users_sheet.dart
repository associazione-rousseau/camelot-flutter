import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/interface/has_list.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/providers/interface/generic_list_provider.dart';
import 'package:rousseau_vote/src/widgets/core/list_provider.dart';
import 'package:rousseau_vote/src/widgets/core/rousseau_list.dart';
import 'package:rousseau_vote/src/widgets/sheet/rousseau_sheet_widget.dart';
import 'package:rousseau_vote/src/widgets/user/user_row.dart';

class UsersSheet<T extends HasList<User>>
    extends StatelessWidget {
  const UsersSheet({@required this.fetcher});
  final GraphqlFetcher<T> fetcher;

  @override
  Widget build(BuildContext context) {
    return RousseauSheetWidget(
      child: ChangeNotifierProvider<ListProvider<User>>(
        create: (_) {
          final GenericListProvider<T, User> provider =
          GenericListProvider<T, User>();
          provider.onFetcherUpdated(fetcher);
          return provider;
        },
        child: RousseauList<ListProvider<User>, User>(
          primary: false,
          itemBuilder: (BuildContext context, User user) =>
              UserRow(user: user),
        ),
      ),
    );
  }
}

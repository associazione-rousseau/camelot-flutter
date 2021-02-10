import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/interface/has_list.dart';
import 'package:rousseau_vote/src/models/user/subscription.dart';
import 'package:rousseau_vote/src/network/fetcher/graphql_fetcher.dart';
import 'package:rousseau_vote/src/providers/interface/generic_list_provider.dart';
import 'package:rousseau_vote/src/widgets/core/list_provider.dart';
import 'package:rousseau_vote/src/widgets/core/rousseau_list.dart';
import 'package:rousseau_vote/src/widgets/sheet/rousseau_sheet_widget.dart';
import 'package:rousseau_vote/src/widgets/user/user_row.dart';

class SubscriptionsSheet<T extends HasList<Subscription>>
    extends StatelessWidget {
  const SubscriptionsSheet({@required this.fetcher});
  final GraphqlFetcher<T> fetcher;

  @override
  Widget build(BuildContext context) {
    return RousseauSheetWidget(
      child: ChangeNotifierProvider<ListProvider<Subscription>>(
        create: (_) {
          final GenericListProvider<T, Subscription> provider =
              GenericListProvider<T, Subscription>();
          provider.onFetcherUpdated(fetcher);
          return provider;
        },
        child: RousseauList<ListProvider<Subscription>, Subscription>(
          primary: false,
          itemBuilder: (BuildContext context, Subscription subscription) =>
              UserRow(user: subscription.user),
        ),
      ),
    );
  }
}

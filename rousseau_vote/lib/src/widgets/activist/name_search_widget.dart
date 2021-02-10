import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/providers/activists_search_provider.dart';
import 'package:rousseau_vote/src/widgets/core/search_widget.dart';

class NameSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ActivistsSearchProvider provider =
        Provider.of<ActivistsSearchProvider>(context);
    return SearchWidget(
      labelTextKey: 'activist-search-by-name',
      hintTextKey: 'activist-search-by-name-hint',
      onSubmitted: (String word) => provider.onSearch(context, word),
    );
  }
}

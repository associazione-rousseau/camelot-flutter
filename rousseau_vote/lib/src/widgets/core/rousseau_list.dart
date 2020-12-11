import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/widgets/errors/error_page_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'list_provider.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T object);
typedef NoResultsBuilder = Widget Function(BuildContext context);

class RousseauList<P extends ListProvider<T>, T> extends StatelessWidget {
  const RousseauList(
      {@required this.itemBuilder,
        this.noResultsBuilder,
        this.pullToRefresh = false,
        this.primary = true,
        this.padding = 20});

  final ItemBuilder<T> itemBuilder;
  final NoResultsBuilder noResultsBuilder;
  final bool pullToRefresh;
  final double padding;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final P provider = Provider.of(context);
    if (provider.isLoading()) {
      return const Padding(
        padding: EdgeInsets.only(top: 20),
        child: LoadingIndicator(),
      );
    }
    if (provider.hasErrors()) {
      return RefreshIndicator(onRefresh: provider.pullToRefresh, child: _errorBody());
    }
    if (provider.getItemCount() == 0) {
      return noResultsBuilder != null ? noResultsBuilder(context) : Container();
    }
    return pullToRefresh
        ? RefreshIndicator(onRefresh: provider.pullToRefresh, child: _body(provider))
        : _body(provider);
  }

  // hack to allow the pull to refresh without moving the error message
  Widget _errorBody() {
    return Stack(
        children: [
          const ErrorPageWidget(),
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(height: 2000, width: 2000, color: Colors.transparent,)
              ],
            ),
          ),
        ]
    );
  }


  Widget _body(ListProvider<T> provider) {
    return ListView.separated(
      primary: primary,
      shrinkWrap: !primary,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: padding),
      padding: EdgeInsets.all(padding),
      itemCount: provider.canLoadMore()
          ? provider.getItemCount() + 1
          : provider.getItemCount(),
      itemBuilder: (BuildContext context, int index) {
        if (index == provider.getItemCount()) {
          return VisibilityDetector(
              key: const Key('rousseau-list-load-more'),
              child: const LoadingIndicator(),
              onVisibilityChanged: (VisibilityInfo visibilityInfo) {
                if(visibilityInfo.visibleFraction == 1) {
                  provider.loadMore();
                }
              });
        }
        return itemBuilder(context, provider.getItem(index));
      },
    );
  }
}

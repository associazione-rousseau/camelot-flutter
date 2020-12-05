import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/network/fetcher/fetcher.dart';
import 'package:rousseau_vote/src/models/interface/has_list.dart';
import 'package:rousseau_vote/src/providers/interface/list_provider.dart';
import 'package:rousseau_vote/src/widgets/errors/error_page_widget.dart';
import 'package:rousseau_vote/src/widgets/loading_indicator.dart';
import 'package:visibility_detector/visibility_detector.dart';

typedef ItemBuilder<I> = Widget Function(BuildContext context, I object);

class RousseauList<T extends HasList<I>, I> extends StatelessWidget {
  const RousseauList(
      {@required this.fetcher,
      @required this.itemBuilder,
      this.pullToRefresh = false,
      this.padding = 20});

  final Fetcher<T> fetcher;
  final ItemBuilder<I> itemBuilder;
  final bool pullToRefresh;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ListProvider<T, I>>(
        create: (BuildContext context) => ListProvider<T, I>(fetcher: fetcher),
        child: Consumer<ListProvider<T, I>>(builder:
            (BuildContext context, ListProvider<T, I> provider, Widget child) {
          if (provider.isLoading) {
            return const LoadingIndicator();
          }
          if (provider.hasError) {
            return const ErrorPageWidget();
          }
          return pullToRefresh
              ? RefreshIndicator(
                  onRefresh: provider.pullToRefresh, child: _body(provider))
              : _body(provider);
        }),
      ),
    );
  }

  Widget _body(ListProvider<T, I> provider) {
    return ListView.separated(
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

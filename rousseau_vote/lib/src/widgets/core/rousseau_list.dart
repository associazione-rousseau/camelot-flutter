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
      this.primary = true,
      this.padding = 20});

  final Fetcher<T> fetcher;
  final ItemBuilder<I> itemBuilder;
  final bool pullToRefresh;
  final double padding;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListProvider<T, I>>(
        create: (BuildContext context) => ListProvider<T, I>(fetcher: fetcher),
        child: Consumer<ListProvider<T, I>>(builder:
            (BuildContext context, ListProvider<T, I> provider, Widget child) {
          if (provider.isLoading) {
            return const LoadingIndicator();
          }
          return pullToRefresh
              ? RefreshIndicator(
                  onRefresh: provider.pullToRefresh,
                  child: provider.hasError ? _errorBody() : _body(provider))
              : _body(provider);
        }),
    );
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


  Widget _body(ListProvider<T, I> provider) {
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

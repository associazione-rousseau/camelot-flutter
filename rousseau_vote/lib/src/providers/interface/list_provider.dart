
import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/network/fetcher/fetcher.dart';
import 'package:rousseau_vote/src/models/interface/has_list.dart';
import 'package:rousseau_vote/src/models/interface/has_pagination.dart';

class ListProvider<T extends HasList<I>, I> extends ChangeNotifier {

  ListProvider({ @required this.fetcher }) {
    init();
  }

  final Fetcher<T> fetcher;
  T data;
  bool isLoading = false;
  bool hasError = false;

  void init() => _fetchAndNotify(fetcher.fetch());

  bool canLoadMore() => data is HasPagination && (data as HasPagination).hasNext();

  void loadMore() => _fetchAndNotify(fetcher.loadMore(data), isLoadMore: true);

  Future<void> pullToRefresh() async {
    final T data = await fetcher.refresh();
    if (data != null) {
      this.data = data;
      notifyListeners();
    }
  }

  int getItemCount() => data.getItemCount();

  I getItem(int index) => data.getItem(index) ;

  void _fetchAndNotify(Future<T> fetchFuture, {bool isLoadMore = false}) {
    if (isLoading) {
      return;
    }

    isLoading = true;
    if (!isLoadMore) {
      notifyListeners();
    }

    fetchFuture.then((T data) {
      if (isLoadMore && this.data is HasPagination && data is HasPagination) {
        (data as HasPagination).mergePreviousPage(this.data as HasPagination);
      }
      this.data = data;
      hasError = false;
    }).catchError((Object error) {
      hasError = true;
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
    });
  }
}

import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/network/fetcher/fetcher.dart';
import 'package:rousseau_vote/src/models/interface/has_list.dart';
import 'package:rousseau_vote/src/models/interface/has_pagination.dart';
import 'package:rousseau_vote/src/widgets/core/list_provider.dart';

class GenericListProvider<T extends HasList<I>, I> extends ListProvider<I> {
  GenericListProvider({ @required Fetcher<T> fetcher }) {
    onFetcherUpdated(fetcher);
  }

  Fetcher<T> fetcher;
  T data;
  bool _isLoading = false;
  bool _hasErrors = false;

  void onFetcherUpdated(Fetcher<T> fetcher) {
    this.fetcher = fetcher;
    load();
  }

  @override
  void load() => _fetchAndNotify(fetcher.fetch());

  @override
  bool canLoadMore() =>
      data is HasPagination && (data as HasPagination).hasNext();

  @override
  void loadMore() => _fetchAndNotify(fetcher.loadMore(data), isLoadMore: true);

  @override
  Future<void> pullToRefresh() async {
    final T data = await fetcher.refresh();
    if (data != null) {
      this.data = data;
      notifyListeners();
    }
  }

  @override
  int getItemCount() => data.getItemCount();

  @override
  I getItem(int index) => data.getItem(index);

  void _fetchAndNotify(Future<T> fetchFuture, {bool isLoadMore = false}) {
    if (_isLoading) {
      return;
    }

    _isLoading = true;
    if (!isLoadMore) {
      notifyListeners();
    }

    fetchFuture.then((T data) {
      if (isLoadMore && this.data is HasPagination && data is HasPagination) {
        (data as HasPagination).mergePreviousPage(this.data as HasPagination);
      }
      this.data = data;
      _hasErrors = false;
    }).catchError((Object error) {
      _hasErrors = true;
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    });
  }

  @override
  bool hasErrors() => _hasErrors;

  @override
  bool isLoading() => _isLoading;
}

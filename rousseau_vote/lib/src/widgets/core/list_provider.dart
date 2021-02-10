
import 'package:flutter/cupertino.dart';

abstract class ListProvider<T> extends ChangeNotifier {
  void load();

  bool canLoadMore();

  void loadMore();

  Future<void> pullToRefresh();

  bool isLoading();

  bool hasErrors();

  int getItemCount();

  T getItem(int index);
}
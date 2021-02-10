
abstract class Fetcher<T> {
  Future<T> fetch();
  Future<T> loadMore(T currentData);
  Future<T> refresh();
}

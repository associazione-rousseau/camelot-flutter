
import 'package:rousseau_vote/src/models/interface/has_list.dart';
import 'package:rousseau_vote/src/models/interface/paginated.dart';

abstract class HasPagination<T> extends HasList<T> {

  Paginated<T> getPaginatedData();

  String afterCursor() => getPaginatedData().afterCursor();

  bool hasNext() => getPaginatedData().hasNext();

  void mergePreviousPage(HasPagination<T> newData) => getPaginatedData().mergePreviousPage(newData.getPaginatedData());

  @override
  int getItemCount() => getPaginatedData() != null && getPaginatedData().nodes != null ? getPaginatedData().nodes.length : 0;

  @override
  T getItem(int index) => getPaginatedData().nodes[index];
}

import 'package:rousseau_vote/src/models/interface/has_list.dart';
import 'package:rousseau_vote/src/models/interface/paginated.dart';

abstract class HasPagination<T> extends HasList<T> {

  Paginated<T> getPaginatedData();

  void mergePreviousPage(HasPagination<T> newData);

  bool hasNext();

  String afterCursor();
}
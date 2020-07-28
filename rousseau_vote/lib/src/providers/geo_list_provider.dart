import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/widgets/graphql_query_widget.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_queries.dart';
import 'dart:convert';

class GeoListProvider extends ChangeNotifier {
  List<String> _items;
  String _selectedItem;

  List<String> get items => _items;
  String get selected => _selectedItem;

  void setSelectedItem(String s) {
    _selectedItem = s;
    notifyListeners();
  }
}

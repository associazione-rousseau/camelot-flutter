//import 'package:injectable/injectable.dart';
//import 'package:rousseau_vote/src/injection/injector_config.dart';
//import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
//import 'package:rousseau_vote/src/network/handlers/search/search_handler.dart';
//import 'package:rousseau_vote/src/search/suggestion_types.dart';
//
//@injectable
//class PositionSearchHandler implements SearchHandler {
//  static const int RESULTS_LIMIT = 3;
//
//  @override
//  Future<List<SuggestionType<ItalianGeographicalDivision>>> search(String word) async {
//
//
//    final UserNetworkHandler userNetworkHandler = getIt<UserNetworkHandler>();
//    final Positions positions = await userNetworkHandler.fetchAllPositions();
//    final List<SuggestionType<Position>> positionSuggestions = <SuggestionType<Position>>[];
//    for (Position position in positions.positions) {
//      positionSuggestions.add(PositionSuggestion(position));
//    }
//    return positionSuggestions;
//  }
//}

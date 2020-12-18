import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/profile/position.dart';
import 'package:rousseau_vote/src/models/profile/positions.dart';
import 'package:rousseau_vote/src/network/handlers/search/search_handler.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/search/suggestion_types.dart';

@injectable
class PositionSearchHandler implements SearchHandler {
  @override
  Future<List<SuggestionType<Position>>> search(String word) async {
    final UserNetworkHandler userNetworkHandler = getIt<UserNetworkHandler>();
    final Positions positions = await userNetworkHandler.fetchAllPositions();
    final List<SuggestionType<Position>> positionSuggestions = <SuggestionType<Position>>[];
    for (Position position in positions.positions) {
      if (position.name.contains(word)) {
        positionSuggestions.add(PositionSuggestion(position));
      }
    }
    return positionSuggestions;
  }
}


import 'package:rousseau_vote/src/models/poll_detail.dart';
import 'package:rousseau_vote/src/models/poll_list.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/graphql/parser/poll_detail_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/query_response_parser.dart';
import 'package:rousseau_vote/src/network/graphql/parser/user_profile_parser.dart';

import 'current_user_parser.dart';
import 'poll_list_parser.dart';

Map<Type, QueryResponseParser<dynamic>> map = <Type, QueryResponseParser<dynamic>>{
  PollList: PollListParser(),
  PollDetail: PollDetailParser(),
  CurrentUser: CurrentUserParser(),
  UserProfile: UserProfileParser(),
};

QueryResponseParser<T> getParser<T>() {
  return map[T];
}


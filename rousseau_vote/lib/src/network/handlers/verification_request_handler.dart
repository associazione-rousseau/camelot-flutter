
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/network/graphql/graphql_mutations.dart';
import 'package:rousseau_vote/src/network/handlers/image_upload_handler.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/util/graphql_util.dart';

@singleton
class VerificationRequestHandler {

  Future<bool> sendVerificationRequest(PickedFile file) async {
    final ImageUploadHandler imageUploadHandler = getIt<ImageUploadHandler>();
    final String signedId = await imageUploadHandler.uploadImage(file);

    final GraphQLClient client = getIt<GraphQLClient>();
    final Map<String, List<String>> ids = { 'documentIds': <String>[signedId] };
    final MutationOptions options = MutationOptions(
        documentNode: gql(submitIdentityVerificationRequest),
        variables: ids);
    final QueryResult result = await client.mutate(options);

    // prefetch current user
    await getIt<UserNetworkHandler>().fetchCurrentUser(fetchPolicy: FetchPolicy.networkOnly);

    return result.success;
  }
}
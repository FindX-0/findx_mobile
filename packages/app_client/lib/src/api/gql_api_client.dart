import 'package:gql_types/gql_types.dart';
import 'package:graphql/client.dart';

class GqlApiClient {
  GqlApiClient(this._client);

  final GraphQLClient _client;

  Future<Query$GetAuthUser$getAuthUser?> getAuthUser() async {
    final result = await _client.query$GetAuthUser();

    return result.parsedData?.getAuthUser;
  }
}

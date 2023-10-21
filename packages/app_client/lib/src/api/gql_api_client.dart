import 'package:graphql/client.dart';

import '../gql/query/say_hello.gql.dart';

class GqlApiClient {
  GqlApiClient(this._client);

  final GraphQLClient _client;

  Future<Query$SayHello?> fetchSayHello() async {
    final result = await _client.query$SayHello();

    return result.parsedData;
  }
}

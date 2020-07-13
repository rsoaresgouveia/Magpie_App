import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConf {
  static HttpLink httpLink = HttpLink(
      uri: "https://sad-kapitsa-2407.edgestack.me/internal/front/graphql");
  //static AuthLink authLink = AuthLink();
  static Link link = httpLink;

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: link,
      cache: InMemoryCache(),
    );
  }
}

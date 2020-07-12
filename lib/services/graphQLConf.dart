import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConf {
  static HttpLink httpLink = HttpLink(
      uri: "https://sad-kapitsa-2407.edgestack.me/internal/front/graphql");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    );
  }
}

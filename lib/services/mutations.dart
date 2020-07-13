import 'package:graphql_flutter/graphql_flutter.dart';

class Mutations {
  String registerUser(
    String name,
    String email,
    String username,
    String password,
  ) {
    return """
      mutation{
        register(
          name: "$name", 
          email: "$email", 
          username: "$username", 
          password: "$password")
        {
          token,
          error
        }
      }
    """;
  }

  String login(
    String email,
    String username,
    String password,
  ) {
    return """
      mutation{
        login(
          email: "$email", 
          username: "$username", 
          password: "$password")
        {
          token
        }
      }
    """;
  }
}

// register(
// name: String!
// email: String!
// username: String!
// password: String!
// ): AuthResponse

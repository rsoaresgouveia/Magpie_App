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
        register(name: "$name", email: "$email", username: "$username", password: "$password"){
          name
          email
          username
          password
        }
      }
    """;
  }

  String newPost(
    String title,
    String text,
    String token,
  ) {
    return """
      mutation{
        register(title: "$title", text: "$text", token: "$token"){
          title
          text
          token
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
        register(email: "$email", username: "$username", password: "$password"){
          email
          username
          password
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

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

  String newPost(
    String title,
    String text,
    String token,
  ) {
    return """
      mutation{
        newPost(
          title:"$title",
          text: "$text",
          token: "$token"
        ){
          post{
            id: id,
            title: title,
            text: text,
            author: author{
              name: name,
              id:id,
              email: email,
              username: username,
              token: token,
            },
            
          }
          error,
        }
      }
    """;
  }
}

/*







*/

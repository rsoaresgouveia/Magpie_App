class Queries {
  String getMe(String token) {
    return """
      query{
        me (token: "$token")
      }
    """;
  }

  String getPosts() {
    return """"
      query{
        posts
      }
    """;
  }
}

class Queries {
  String getMe(String token) {
    return """
      query{
	      me(token:"$token"){
          id: id,
          name: name,
          email: email,
          username: username,
          token: token,
        }
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


class SignIn {
  String? password,userName;

  SignIn({this.password,this.userName});

  SignIn.fromJson(Map<String, dynamic> jsonMap) {
    password = jsonMap['password'];
    userName = jsonMap['login'];
   }

  Map<String, dynamic> toJson() {
    return {
      "login_as": "2",
      "login": userName,
      "password": password
    };
  }
}

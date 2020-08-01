final String preUsername = 'sachin';
final String prePassword = '12345';

class User {
  final String username;
  final String password;

  User({this.username, this.password});
}

bool checkValidity(String username, String password) {
  if (username == preUsername && password == prePassword)
    return true;
  else
    return false;
}

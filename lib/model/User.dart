
class User
{
  final String username;
	final String password;
	final String hint;
	final DateTime createdDate;
	final DateTime lastLogin;
	final String blabName;
	final String realName;

  const User({
    required this.username,
    required this.password,
    required this.hint,
    required this.lastLogin,
    required this.createdDate,
    required this.blabName,
    required this.realName,
  });

  factory User.fromJson(Map<String, dynamic> json)
  {
    return switch (json) {
      {
      'username': String username,
      'password': String password,
      'hint' : String hint,
      'lastLogin' : DateTime lastLogin,
      'createdDate' : DateTime createdDate,
      'blabName' : String blabName,
      'realName' : String realName
      } => User(username: username, password: password, hint: hint, lastLogin: lastLogin,
       createdDate: createdDate, blabName: blabName, realName: realName),
      _=> throw const FormatException('Failed to create User.'),
    };
  }
}
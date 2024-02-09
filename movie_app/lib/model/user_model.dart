class User {
  User({
    required this.id,
    required this.userName,
    required this.userNumber,
    required this.userEmail,
    required this.userPassword,
  });
  late final String id;
  late final String userName;
  late final String userNumber;
  late final String userEmail;
  late final String userPassword;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    userNumber = json['userNumber'];
    userEmail = json['userEmail'];
    userPassword = json['userPassword'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['userNumber'] = userNumber;
    data['userEmail'] = userEmail;
    data['userPassword'] = userPassword;
    return data;
  }
}

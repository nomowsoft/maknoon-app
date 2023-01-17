class AuthModel {
  String displayName;
  int teachId;
  int userId;
  String gender;
  String loginAs;

  AuthModel(
      {required this.displayName,
      required this.teachId,
      required this.userId,
      required this.gender,
      required this.loginAs});

  AuthModel.fromJson(Map<String, dynamic> json):
    displayName = json['display_name'],
    teachId = json['teach_id'],
    userId = json['user_id'],
    gender = json['gender']
    ,loginAs = json['login_as'];
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['display_name'] = displayName;
    data['teach_id'] = teachId;
    data['user_id'] = userId;
    data['gender'] = gender;
    data['login_as'] = loginAs;
    return data;
  }

  @override
  String toString() {
    return 'AuthModel{displayName: $displayName, teachId: $teachId, userId: $userId, gender: $gender,loginAs: $loginAs}';
  }
}

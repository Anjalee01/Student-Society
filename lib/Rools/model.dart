class UserModel {
  String? email;
  String? wrool;
  String? uid;
  String? fullName;
  bool? voting;
  bool? active;

// receiving data
  UserModel(
      {this.uid,
      this.email,
      this.wrool,
      this.fullName,
      this.voting,
      this.active});
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      wrool: map['wrool'],
      voting: map['voting'],
      active: map['active'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'uid': uid ?? "",
      'email': email ?? "",
      'wrool': wrool ?? "",
      'fullName': fullName ?? "",
      'voting': voting ?? "",
      'active': active ?? "",
    };
  }
}

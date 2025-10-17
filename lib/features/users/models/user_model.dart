class UserModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? userImage;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userImage,
  });

  /// convert Json Data to Model....
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userImage: json['avatar'],
    );
  }

  /// convert Model to Json data....
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': userImage,
    };
  }
}

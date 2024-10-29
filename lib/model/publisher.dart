class Publisher {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? profilePicture;
  String? password;
  String? status;
  String? createdAt;
  String? updatedAt;

  Publisher(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.profilePicture,
      this.password,
      this.status,
      this.createdAt,
      this.updatedAt});

  Publisher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    profilePicture = json['profilePicture'];
    password = json['password'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['profilePicture'] = profilePicture;
    data['password'] = password;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

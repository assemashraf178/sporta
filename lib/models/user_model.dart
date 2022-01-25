class UserModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? city;
  String? age;
  String? trainingType;
  String? gender;
  String? uId;

  UserModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.city,
    this.age,
    this.trainingType,
    this.gender,
    this.uId,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    age = json['age'];
    trainingType = json['trainingType'];
    gender = json['gender'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'age': age,
      'gender': gender,
      'trainingType': trainingType,
    };
  }
}

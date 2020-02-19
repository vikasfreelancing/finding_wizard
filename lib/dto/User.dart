class User {
  String Id;
  String name;
  String email;
  String password;
  String phone;
  String aadhar;
  User();
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'aadhar': aadhar
      };
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        password = json['password'],
        Id = json['Id'],
        phone = json['phone'];
}

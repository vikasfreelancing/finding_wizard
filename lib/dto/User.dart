class User {
  String id;
  String name;
  String email;
  String password;
  String phone;
  String aadhar;
  String message;
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
        id = json['id'],
        phone = json['phone'];
}

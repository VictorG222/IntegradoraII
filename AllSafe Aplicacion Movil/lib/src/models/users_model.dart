class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password});

  factory UserModel.fromMapJson(Map<String, dynamic> api) => UserModel(
      id: api['id'],
      name: api['name'],
      email: api['email'],
      password: api['password']);

  Map<String, dynamic> tojson() =>
      {'nombre': name, 'email': email, 'password': password};
}

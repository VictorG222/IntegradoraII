class LoginModel {
  String? correo;
  String? password;

  LoginModel({this.correo, this.password});

  Map<String, dynamic> toJson() =>
      {'correo': this.correo, 'password': this.password};
}

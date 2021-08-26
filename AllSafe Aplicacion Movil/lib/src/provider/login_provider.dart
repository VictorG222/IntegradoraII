import 'package:allsafe_appmobile/src/models/login_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LoginProvider extends GetxController {
  final _http = Dio();
  final _url = 'http://localhost:3000/api/auth/signin';
  late LoginModel usuario;
  final _storage = FlutterSecureStorage();
  final key = GlobalKey<FormState>();

  Future<String?> login() async {
    final _response = await _http.post(_url, data: usuario.toJson());
    final _data = _response.data['token'];
    if (_response.statusCode == 200) {
      _storage.write(key: 'token', value: _data);
      return null;
    } else {
      return _response.data;
    }
  }

  Future<void> logout() async {
    if (await _storage.read(key: 'token') == null) {
      _storage.delete(key: 'token');
    }
  }

  bool checkValidator() => key.currentState!.validate();

  Future<String?> checkStorageToken() async {
    return await _storage.read(key: 'token') ?? '';
  }
}

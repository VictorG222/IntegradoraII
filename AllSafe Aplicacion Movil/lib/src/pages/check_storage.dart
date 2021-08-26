import 'package:allsafe_appmobile/src/models/login_model.dart';
import 'package:allsafe_appmobile/src/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:allsafe_appmobile/src/models/login_model.dart';
import 'package:allsafe_appmobile/src/provider/login_provider.dart';

class CheckStorage extends StatelessWidget {
  final _loginProvider = Get.put(LoginProvider());
  @override
  Widget build(BuildContext context) {
    _loginProvider.usuario = LoginModel(correo: '', password: '');
    return FutureBuilder(
        future: _loginProvider.checkStorageToken(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == '') {
            Future.microtask(
                () => Navigator.pushReplacementNamed(context, '/dashboard'));
          } else {
            Future.microtask(
                () => Navigator.pushReplacementNamed(context, '/login'));
          }
          return Container();
        });
  }
}

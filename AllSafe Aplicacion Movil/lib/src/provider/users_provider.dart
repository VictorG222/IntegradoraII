import 'package:allsafe_appmobile/src/models/users_model.dart';
import 'package:dio/dio.dart';

class UserProvider {
  final _url = 'https://allsalfe.herokuapp.com/api/users';
  final _http = Dio();

  Future<List<UserModel>> ObtenerUsers() async {
    final _response = await _http.get(_url);
    List<dynamic> data = _response.data;
    return data.map((api) => UserModel.fromMapJson(api)).toList();
  }
}

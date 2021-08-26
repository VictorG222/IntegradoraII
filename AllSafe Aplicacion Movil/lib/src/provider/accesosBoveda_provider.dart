import 'package:allsafe_appmobile/src/models/accesosBoveda_model.dart';
import 'package:dio/dio.dart';

class AccesoBovedaProvider {
  final _url = 'https://allsalfe.herokuapp.com/api/accesoBoveda';
  final _http = Dio();

  Future<List<AccesoBovedaModel>> ObtenerAccesos() async {
    final _response = await _http.get(_url);
    List<dynamic> data = _response.data;
    return data.map((api) => AccesoBovedaModel.fromMapJson(api)).toList();
  }
}

import 'package:allsafe_appmobile/src/models/movimiento_model.dart';
import 'package:dio/dio.dart';

class MovimientoProvider {
  final _url = 'https://allsalfe.herokuapp.com/api/movimiento';
  final _http = Dio();

  Future<List<MovimientoModel>> ObtenerMovimientos() async {
    final _response = await _http.get(_url);
    List<dynamic> data = _response.data;
    return data.map((api) => MovimientoModel.fromMapJson(api)).toList();
  }
}

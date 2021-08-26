class AccesoBovedaModel {
  String? id;
  String? fecha;
  String? hora;
  String? estado;

  AccesoBovedaModel(
      {required this.id,
      required this.fecha,
      required this.hora,
      required this.estado});

  factory AccesoBovedaModel.fromMapJson(Map<String, dynamic> api) =>
      AccesoBovedaModel(
          id: api['id'],
          fecha: api['fecha'],
          hora: api['hora'],
          estado: api['estado']);
}

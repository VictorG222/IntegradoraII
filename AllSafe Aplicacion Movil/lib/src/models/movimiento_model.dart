class MovimientoModel {
  String? id;
  String? fecha;
  String? hora;
  String? alerta;

  MovimientoModel(
      {required this.id,
      required this.fecha,
      required this.hora,
      required this.alerta});

  factory MovimientoModel.fromMapJson(Map<String, dynamic> api) =>
      MovimientoModel(
          id: api['id'],
          fecha: api['fecha'],
          hora: api['hora'],
          alerta: api['alerta']);
}

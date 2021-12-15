import 'dart:convert';

List<Inversor> inversorFromJson(String str) => List<Inversor>.from(json.decode(str).map((x) => Inversor.fromJson(x)));

String inversorToJson(List<Inversor> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Inversor {
  Inversor({
    this.nombre,
    this.monto,
    this.comision,
    this.telefono,
  });

  String? nombre;
  double? monto;
  double? comision;
  String? telefono;

  factory Inversor.fromJson(Map<String, dynamic> json) => Inversor(
    nombre: json["nombre"],
    monto: json["monto"].toDouble(),
    comision: json["comision"].toDouble(),
    telefono: json["telefono"],
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "monto": monto,
    "comision": comision,
    "telefono": telefono,
  };
}

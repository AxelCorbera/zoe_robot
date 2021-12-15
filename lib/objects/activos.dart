import 'dart:convert';

List<Activos> activosFromJson(String str) => List<Activos>.from(json.decode(str).map((x) => Activos.fromJson(x)));

String activosToJson(List<Activos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Activos {
  Activos({
    this.id,
    this.usuario,
    this.informacion,
    this.inversores,
    this.inversion,
    this.comision,
    this.pagar,
    this.cobrar
  });

  String? id;
  String? usuario;
  String? informacion;
  String? inversores;
  String? inversion;
  String? comision;
  String? pagar;
  String? cobrar;

  factory Activos.fromJson(Map<String, dynamic> json) => Activos(
    id: json["id"],
    usuario: json["usuario"],
    informacion: json["informacion"],
    inversores: json["inversores"],
    inversion: json["inversion"],
    comision: json["comision"],
    pagar: json["pagar"],
    cobrar: json["cobrar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "usuario": usuario,
    "informacion": informacion,
    "inversores": inversores,
    "inversion": inversion,
    "comision": comision,
    "pagar": pagar,
    "cobrar": cobrar,
  };
}
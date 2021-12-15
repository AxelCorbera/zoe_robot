// To parse this JSON data, do
//
//     final ingreso = ingresoFromJson(jsonString);

import 'dart:convert';

Ingreso ingresoFromJson(String str) => Ingreso.fromJson(json.decode(str));

String ingresoToJson(Ingreso data) => json.encode(data.toJson());

class Ingreso {
  Ingreso({
    this.id,
    this.nombre,
    this.apellido,
    this.correo,
    this.clave,
  });

  String? id;
  String? nombre;
  String? apellido;
  String? correo;
  String? clave;

  factory Ingreso.fromJson(Map<String, dynamic> json) => Ingreso(
    id: json["id"],
    nombre: json["nombre"],
    apellido: json["apellido"],
    correo: json["correo"],
    clave: json["clave"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "apellido": apellido,
    "correo": correo,
    "clave": clave,
  };
}

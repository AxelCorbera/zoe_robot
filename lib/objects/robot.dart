import 'dart:convert';

import 'inversor.dart';

List<String> listaRobotFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String listaRobotToJson(List<Robot> data) => json.encode(List<Robot>.from(data.map((x) => robotToJson(x))));
//List<Cards> cardsFromJson(String str) => List<Cards>.from(json.decode(str).map((x) => Cards.fromJson(x)));

Robot robotFromJson(String str) => Robot.fromJson(json.decode(str));

String robotToJson(Robot data) => json.encode(data.toJson());

class Robot{
  int id;
  final String nombre;
  double duracion;
  int pago;
  DateTime inicio;
  bool gradual;
  int gInicial;
  int gAumento;
  bool devuelve;

  Robot(this.id,
      this.nombre,
      this.duracion,
      this.pago,
      this.inicio,
      this.gradual,
      this.gInicial,
      this.gAumento,
      this.devuelve
      );

  factory Robot.fromJson(Map<String, dynamic> json) => Robot(
    json["id"],
    json["nombre"],
    json["duracion"],
    json["pago"],
    DateTime.parse(json["inicio"]),
    json["gradual"],
    json["gInicial"],
    json["gAumento"],
    json["devuelve"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "duracion": duracion,
    "pago": pago,
    "inicio": inicio.toString(),
    "gradual": gradual,
    "gInicial": gInicial,
    "gAumento": gAumento,
    "devuelve": devuelve,

  };
}
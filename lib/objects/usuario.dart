import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
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

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
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

import 'dart:convert';

import 'package:zoe/globals.dart';
import 'package:zoe/objects/activos.dart';
import 'package:zoe/objects/inversor.dart';
import 'package:zoe/objects/robot.dart';
import 'package:http/http.dart' as http;
import 'package:zoe/objects/usuario.dart';

Future<String> CargarRobot(Robot robot, List<Inversor> inversores,
    double inversion, double comision, double pagar, double cobrar) async {
  Map<String, dynamic> info = robot.toJson();

  try {
    Map map = new Map<String, dynamic>();
    map['usuario'] = datosUsuario.id.toString();;
    map['info'] = robotToJson(robot);
    map['inv'] = inversorToJson(inversores);
    map['inversion'] = inversion.toString();
    map['comision'] = comision.toString();
    map['pagar'] = pagar.toString();
    map['cobrar'] = cobrar.toString();


    final response = await http.post(
        Uri.parse('http://wh534614.ispot.cc/zoe_bot/cargarRobot.php?'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: map);

    //print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      //print('cargar robot: ' + response.body);
      return response.body;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create robot.');
    }
  }catch(Exception){
    //print('Failed to create robot.' + Exception.toString());
    return '0';
  }
}

Future<List<Activos>> DescargarRobot() async {
  List<Activos> robot = [];

  String usuario = datosUsuario.id.toString();

  final response = await http.get(
    Uri.parse(
        'http://wh534614.ispot.cc/zoe_bot/descargarRobot.php?usuario=$usuario'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
  );
  try {
    //print(response.statusCode);
    //print('descargar robot: ' + response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      robot = activosFromJson(response.body);

      return robot;
    } else {
      throw Exception('Failed to create robot.');
    }
  } catch (Exception) {
    //print(Exception.toString() + " descargar robot");
    return robot;
  }
}

Future<String> BorrarRobot(String id) async {

    final response = await http.get(
        Uri.parse('http://wh534614.ispot.cc/zoe_bot/borrarRobot.php?id=$id'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
    );

    try{
    //print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      //print('borrar robot: ' + response.body);
      return response.body;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to delete robot.');
    }
  }catch(Exception){
    //print('Failed to delete robot.' + Exception.toString());
    return '0';
  }
}

Future<Usuario> logueo(String correo, String clave) async {
  Usuario usuario = Usuario();

  final response = await http.get(
    Uri.parse(
        'http://wh534614.ispot.cc/zoe_bot/ingreso.php?'
            'correo=$correo&clave=$clave'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
  );
  try {
    //print(response.request!.url.toString());
    //print('iniciar sesion: ' + response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      usuario = usuarioFromJson(response.body);

      return usuario;
    } else {
      throw Exception('Failed to create robot.');
    }
  } catch (Exception) {
    //print(Exception.toString() + " error al iniciar seseion");
    return usuario;
  }
}

Future<String> CrearUsuario(String nombre, String correo, String clave) async {
  String query = "INSERT INTO `USUARIOS`(`nombre`, `apellido`, `correo`, `clave`) "
      "VALUES ('$nombre','','$correo','$clave')";

  Map map = new Map<String, dynamic>();
  map['query'] = query;
  map['email'] = correo;

  final response = await http.post(
    Uri.parse(
        'http://wh534614.ispot.cc/zoe_bot/crearCuenta.php?'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: map,
  );
  try {
    //print(response.request!.url.toString());
    //print('iniciar sesion: ' + response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to create robot.');
    }
  } catch (Exception) {
    //print(Exception.toString() + " error al iniciar seseion");
    return response.body;
  }
}
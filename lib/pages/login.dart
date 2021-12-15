import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoe/constants/themes.dart';
import 'package:zoe/database/json/ingreso.dart';
import 'package:zoe/database/request.dart';
import 'package:zoe/objects/usuario.dart';

import '../globals.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool autoIniciar = false;
  bool _loading = false;
  String userName = '';
  String password = '';
  String _errorMessage = "";
  GlobalKey<FormState> _keyForm = GlobalKey();
  GlobalKey<ScaffoldState> _keyScaf = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaf,
      body: Container(
        child: Form(
          key: _keyForm,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/3,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: Colores.combinacion1,
                            begin: AlignmentDirectional.topStart,
                            end: AlignmentDirectional.bottomEnd
                        )
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 250,
                      height: MediaQuery.of(context).size.height/3,
                      child: Image.asset(
                        'lib/assets/images/logo-white-zoebot.png',
                        height: 250,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 35),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Acceder',
                    style: TextStyle(
                      fontSize: 30
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Correo",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.none,
                                ),
                              ),
                              //filled: true,
                              contentPadding: EdgeInsets.all(16),
                            ),
                            onSaved: (value) {
                              userName = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: "Clave",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.none,
                                ),
                              ),
                              //filled: true,
                              contentPadding: EdgeInsets.all(16),),
                            obscureText: true,
                            onSaved: (value) {
                              password = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text('Iniciar automaticamente',
                                style: TextStyle(
                                  color: Colors.grey[700]
                                ),),
                              ),
                              Switch(
                                  activeTrackColor:
                                  Theme.of(context).secondaryHeaderColor,
                                  activeColor: Colors.white,
                                  value: autoIniciar,
                                  onChanged: (value){
                                    setState(() {
                                      autoIniciar = value;
                                    });
                              })
                            ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(onPressed: () {
                                Navigator.of(context).pushNamed('/Register')
                                .then((value) => showInSnackBar(value.toString()));
                              }, child: Text(
                                'Crear cuenta',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colores.azul_claro
                                ),
                              ),),
                              FlatButton(onPressed: () {}, child: Text(
                                '¿Olvidaste tu clave?',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colores.azul_claro
                                ),
                              ),),
                            ],
                          ),
                          Container(
                            width: 320,
                            child: RaisedButton(
                              onPressed: () async{
                                if(_keyForm.currentState!.validate()){
                                  _keyForm.currentState!.save();
                                }
                                _loading;
                                if(userName.characters.contains(' ')){
                                  userName.replaceAll(' ', '');
                                  //print('se borro un espacio');
                                }
                                await logueo(userName, password)
                                .then((value) => respuesta(value))
                                    .catchError((error, stackTrace) {
                                  // error is SecondError
                                  _mensaje('Error al iniciar', 'Usuario o clave son incorrectos');
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colores.amarillo,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 88.0, minHeight: 45.0),
                                  // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Ingresar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15
                                        ),
                                      ),
                                      if (_loading)
                                        Container(
                                          height: 20,
                                          width: 20,
                                          margin: const EdgeInsets.only(left: 20),
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Divider(),
                          //if (_errorMessage.isNotEmpty)
                            // Padding(
                            //   padding: const EdgeInsets.all(18.0),
                            //   child: Text(
                            //     _errorMessage,
                            //     style: TextStyle(
                            //         color: Colores.rojo,
                            //         fontWeight: FontWeight.bold),
                            //     textAlign: TextAlign.center,
                            //   ),
                            // ),

                            //MENSAJE DE ERROR

                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _autoLogin('cargar',Usuario());
  }

  void _autoLogin(String opcion, Usuario datos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(opcion == 'cargar') {
      bool? loginSave = await prefs.getBool('login');

      if (loginSave == true) {
        String? id = await prefs.getString('id');
        String? nombre = await prefs.getString('nombre');
        String? correo = await prefs.getString('correo');
        String? clave = await prefs.getString('clave');

        Usuario user = Usuario(
            id: id,
            nombre: nombre,
            apellido: '',
            correo: correo,
            clave: clave
        );

        datosUsuario = user;
        login = true;
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
      }
    }else if(opcion == 'guardar'){
        await prefs.setBool('login',true);
        await prefs.setString('id',datos.id.toString());
        await prefs.setString('nombre',datos.nombre.toString());
        await prefs.setString('correo',datos.correo.toString());
        await prefs.setString('clave',datos.clave.toString());

        datosUsuario = datos;
        login = true;

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
    }
  }

  void respuesta(Usuario value){
    if(value.id!.isNotEmpty){
      if(autoIniciar){
        _autoLogin('guardar', value);
      }
      else{
        login = true;
        datosUsuario = value;
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
      }
    }else{
       _mensaje('Error de logueo','Usuario o clave son incorrectos');
    }
  }

  void showInSnackBar(String value) {
    if(value!='null')
    _keyScaf.currentState!.showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future<void> _mensaje(String title, String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 20,
                      color: Colors.redAccent),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      msg,
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Aceptar'),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}

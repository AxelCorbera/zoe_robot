import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:zoe/constants/themes.dart';
import 'package:zoe/database/json/ingreso.dart';
import 'package:zoe/database/request.dart';
import 'package:zoe/objects/usuario.dart';

import '../globals.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //final firestoreInstance = FirebaseFirestore.instance;

  bool _loading = false;
  String name = '';
  String userName = '';
  String password = '';
  String _errorMessage = "";
  GlobalKey<FormState> _keyForm = GlobalKey();
  GlobalKey<ScaffoldState> _keyScaf = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _keyScaf,
      body: Form(
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
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Crear cuenta',
                  style: TextStyle(fontSize: 30),
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
                            labelText: "Nombre",
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
                            name = value!;
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
                          decoration: InputDecoration(
                            labelText: "Clave",
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
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
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
                          decoration: InputDecoration(
                            labelText: "Repetir clave",
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
                          obscureText: true,
                          onSaved: (value) {
                            password = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            if (value != password) {
                              return 'Las claves no coinciden';
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: 320,
                          child: RaisedButton(
                            onPressed: () async {
                              if (_keyForm.currentState!.validate()) {
                                _keyForm.currentState!.save();

                                _loading;
                                await CrearUsuario(name, userName, password)
                                    .then((value) => respuesta(value))
                                    .catchError((error, stackTrace) {
                                  // error is SecondError
                                  _mensaje('Error al iniciar',
                                      'Usuario o clave son incorrectos');
                                });
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colores.amarillo,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
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
                                      'Crear cuenta',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    if (_loading)
                                      Container(
                                        height: 20,
                                        width: 20,
                                        margin:
                                            const EdgeInsets.only(left: 20),
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
                        SizedBox(height: 10,),
                        Container(
                          width: 320,
                          child: RaisedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
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
                                      'Cancelar',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
    );
  }

  void respuesta(String value) {
    if (value == '1') {
      Navigator.pop(context,'La cuenta se creo exitosamente!');
    } else if (value == '0'){
      _mensaje('Error de creacion', 'Ocurrio un error inesperado');
    }else if (value == '-1'){
      _mensaje('Error de creacion', 'El correo ingresado ya esta en uso');
    }
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
                  style: TextStyle(fontSize: 20, color: Colors.redAccent),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  msg,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 20,
                ),
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

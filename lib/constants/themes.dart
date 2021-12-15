import 'package:flutter/material.dart';

class Colores {
  static final Color azul = Color(0xff3d7cb0);
  static final Color azul_claro = Color(0xff1e6db3);
  static final Color azul_oscuro = Color(0xff0e518d);
  static final Color verde = Color(0xff00c99c);
  static final Color rojo = Color(0xfff4074e);
  static final Color naranja = Color(0xffFFA100);
  static final Color amarillo = Color(0xffFFBD00);
  static final Color gris = Color(0xff515151);

  static List<Color> combinacion1 = [azul_claro, azul_oscuro];
}

final ThemeData Claro = ThemeData(
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white),
      headline6: TextStyle( color: Colors.white),
      bodyText1:
          TextStyle( color: Colors.white),
    ),
    primaryColor: Colores.azul_claro,
    secondaryHeaderColor: Colores.amarillo,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    //canvasColor: Colores.azulOscuro,
    primaryColorLight: Colores.azul_claro,
    focusColor: Colores.azul_claro,
    hoverColor: Colores.azul_claro,
    hintColor: Colores.azul_claro,
    cursorColor: Colores.azul_claro,
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: Color(0xff02253d),
      labelStyle: TextStyle(
        color: Color(0xff02253d),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          //color: Color(0xff02253d),
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Color(0xff02253d),
          width: 2.0,
        ),
      ),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: Colores.azul_claro));

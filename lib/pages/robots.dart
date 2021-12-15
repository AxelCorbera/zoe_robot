import 'package:flutter/material.dart';
import 'package:zoe/constants/themes.dart';
import 'package:zoe/database/request.dart';
import 'package:zoe/objects/activos.dart';
import 'package:zoe/objects/inversor.dart';
import 'package:zoe/objects/robot.dart';

import '../globals.dart';

class Robots extends StatefulWidget {
  @override
  _RobotsState createState() => _RobotsState();
}

class _RobotsState extends State<Robots> {
  bool busqueda = true;
  double _misInversiones = 0;
  double _compuesto = 0;
  double _inversiones = 0;
  double _totalCobrar = 0;
  double _comisiones = 0;
  double _totalPagar = 0;
  @override
  Widget build(BuildContext context) {
    if (busqueda == true) {
      _misInversiones = 0;
      _compuesto = 0;
      _inversiones = 0;
      _totalCobrar = 0;
      _comisiones = 0;
      _totalPagar = 0;
      consultar();
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Mis Robots"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  busqueda = true;
                });
              },
              icon: const Icon(Icons.update)),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/Add_Bot')
                    .then((value) => setState(() {
                  busqueda = true;
                }));
              },
              icon: const Icon(Icons.add_circle)),
        ],
      ),
      body: busqueda
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : robots.length > 0
              ? Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: ListView.builder(
                            itemCount: robots.length,
                            itemBuilder: (context, index) {
                              double inversion = 0;
                              //print(robots[index]);
                              DateTime a = robots[index].inicio.add(Duration(
                                  days: int.parse((robots[index].duracion * 30)
                                      .toStringAsFixed(0))));
                              int diasConcurridos = DateTime.now()
                                  .difference(robots[index].inicio)
                                  .inDays;
                              int diasTerminar =
                                  a.difference(robots[index].inicio).inDays;
                              //print(
                               //   'concurrido $diasConcurridos de $diasTerminar');

                                List<Inversor> inv =
                                    inversores[index].toList();
                                inv.forEach((element) {
                                  //print(element.monto);
                                  inversion = inversion +
                                      double.parse(element.monto.toString());
                                });
                              return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/Bot', arguments: index)
                                        .then((value) => setState(() {
                                              busqueda = true;
                                            }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        elevation: 5,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 5, 20, 5),
                                          child: SizedBox(
                                            height: 100,
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          robots[index].nombre,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 16,
                                                              color: Theme.of(
                                                                      context)
                                                                  .secondaryHeaderColor),
                                                        ),
                                                        Text(
                                                          'inicio: ' +
                                                              robots[index]
                                                                  .inicio
                                                                  .day
                                                                  .toString() +
                                                              '/' +
                                                              robots[index]
                                                                  .inicio
                                                                  .month
                                                                  .toString() +
                                                              '/' +
                                                              robots[index]
                                                                  .inicio
                                                                  .year
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colores.gris),
                                                        ),
                                                      ]),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          'pago del robot:  ' +
                                                              robots[index]
                                                                  .pago
                                                                  .toString() +
                                                              '%',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colores.gris),
                                                        ),
                                                        Text(
                                                          'inversion: ' +
                                                              inversion.toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colores.gris),
                                                        ),
                                                      ]),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0,10,0,10),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: 5,
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            color: Colors.grey[300],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 5,
                                                          width: MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              diasConcurridos /
                                                              diasTerminar,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                  ));
                            }),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Mi inversion',
                                    style: TextStyle(
                                      color: Colores.gris,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _misInversiones.toString(),
                                    style: TextStyle(
                                      color: Colores.gris,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Interes compuesto',
                                    style: TextStyle(
                                      color: Colores.gris,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _compuesto.toString(),
                                    style: TextStyle(
                                      color: Colores.gris,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total inversiones',
                                    style: TextStyle(
                                      color: Colores.gris,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _inversiones.toString(),
                                    style: TextStyle(
                                      color: Colores.gris,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total a cobrar',
                                    style: TextStyle(
                                      color: Colores.azul,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _totalCobrar.toString(),
                                    style: TextStyle(
                                      color: Colores.azul,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Comisión',
                                    style: TextStyle(
                                      color: Colores.gris,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _comisiones.toString(),
                                    style: TextStyle(
                                      color: Colores.gris,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total a pagar',
                                    style: TextStyle(
                                      color: Colores.amarillo,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _totalPagar.toString(),
                                    style: TextStyle(
                                      color: Colores.amarillo,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                        ))
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/Add_Bot')
                          .then((value) => setState(() {
                                busqueda = true;
                              }));
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Abrir nuevo robot',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  void consultar() async {
    robots = [];
    inversores = [];
    List<Activos> r = await DescargarRobot();
    activos = r;
    r.forEach((element) {
      robots.add(robotFromJson(element.informacion.toString()));
      inversores.add(inversorFromJson(element.inversores.toString()));
      //print(element);
    });
    activos.forEach((element) {
      Robot robot = robotFromJson(element.informacion.toString());
      List<Inversor> i = inversorFromJson(element.inversores.toString());
      i.forEach((element) {
        if(element.nombre == '@'){
          //print('devuelve? ' + robot.devuelve.toString());
          if(robot.devuelve == true){
            // print((double.parse(element.monto.toString()) *
            //     robot.pago / 100)+double.parse(element.monto.toString()));
            _compuesto = _compuesto + (double.parse(element.monto.toString()) *
                robot.pago / 100)+double.parse(element.monto.toString());
          }else {
            // print((double.parse(element.monto.toString()) *
            //     robot.pago / 100));
            _compuesto = _compuesto + (double.parse(element.monto.toString()) *
                robot.pago / 100);
          }
          _misInversiones = _misInversiones + double.parse(element.monto.toString());
        }
      });

      _inversiones = _inversiones + double.parse(element.inversion.toString());
      _totalCobrar = _totalCobrar + double.parse(element.cobrar.toString());
      _comisiones = _comisiones + double.parse(element.comision.toString());
      _totalPagar = _totalPagar + double.parse(element.pagar.toString());
    });
    setState(() {
      busqueda = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoe/constants/themes.dart';
import 'package:zoe/database/request.dart';
import 'package:zoe/objects/activos.dart';
import 'package:zoe/objects/inversor.dart';
import 'package:zoe/objects/robot.dart';
import 'package:intl/intl.dart';
import 'package:zoe/objects/usuario.dart';
import '../globals.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    bool busqueda = true;
    double _misInversiones = 0;
    double _compuesto = 0;
    double _inversiones = 0;
    double _totalCobrar = 0;
    double _comisiones = 0;
    double _totalPagar = 0;
    @override
    Widget build(BuildContext context) {
      final money = new NumberFormat("#,##0.00", "en_US");
      if (busqueda == true) {
        _misInversiones = 0;
        _compuesto = 0;
        _inversiones = 0;
        _totalCobrar = 0;
        _comisiones = 0;
        _totalPagar = 0;
        consultar();
      }
      List<Robot> lista = [];
      lista.add(Robot(-1, 'test', 0, 0, DateTime(2000), false, 0, 0, false));
      robots.forEach((element) {
        //print('id: > ' + element.id.toString());
        lista.add(element as Robot);
      });
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text("Inicio"),
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
                  _mensaje('Desconectarse');
                },
                icon: const Icon(Icons.exit_to_app)),
          ],
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width/1.2,
            height: MediaQuery.of(context).size.height/1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Container(
                  child: Text('Inversiones ',
                    style: TextStyle(
                      color: Colores.gris,
                        fontSize: 13
                    ),),
                ),
                SizedBox(height: 5,),
                Container(
                  child: Text('\$ ' +money.format(_inversiones),
                  style: TextStyle(
                    color: Colores.azul,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 25,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Robots activos',
                              style: TextStyle(
                                  color: Colores.azul,
                                  fontSize: 15
                              ),),
                            Text(activos.length.toString(),
                              style: TextStyle(
                                  color: Colores.azul,
                                  fontSize: 15
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mi inversion',
                              style: TextStyle(
                                  color: Colores.gris,
                                  fontSize: 15
                              ),),
                            Text(money.format(_misInversiones),
                              style: TextStyle(
                                  color: Colores.gris,
                                  fontSize: 15
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Interés compuesto',
                              style: TextStyle(
                                  color: Colores.gris,
                                  fontSize: 15
                              ),),
                            Text(money.format(_compuesto),
                              style: TextStyle(
                                  color: Colores.gris,
                                  fontSize: 15
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total a cobrar',
                              style: TextStyle(
                                  color: Colores.amarillo,
                                  fontSize: 18
                              ),),
                            Text('\$' + money.format(_totalCobrar),
                              style: TextStyle(
                                  color: Colores.amarillo,
                                  fontSize: 18
                              ),),
                          ],
                        ),
                      ),
                    ],),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      elevation: 5,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed('/Robots')
                              .then((value) => setState(() {
                            busqueda = true;
                          }));
                        },
                        child: Container(
                          width: 140,
                          child: Column(children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Icon(Icons.search,
                                  color: Colores.azul,
                                size: 30,)
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: Text('Mis robots',
                                style: TextStyle(
                                    color: Colores.gris,
                                    fontSize: 15
                                ),),
                            ),
                          ],),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      elevation: 5,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed('/Add_Bot')
                              .then((value) => setState(() {
                            busqueda = true;
                          }));
                        },
                        child: Container(
                          width: 140,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Icon(Icons.add_circle,
                                color: Colores.azul,
                                size: 30,)
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: Text('crear robot',
                                style: TextStyle(
                                    color: Colores.gris,
                                    fontSize: 15
                                ),),
                            ),
                          ],),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
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
        // print(element);
      });
      activos.forEach((element) {
        Robot robot = robotFromJson(element.informacion.toString());
        List<Inversor> i = inversorFromJson(element.inversores.toString());
        i.forEach((element) {
          if(element.nombre == '@'){
            // print('devuelve? ' + robot.devuelve.toString());
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

    Future<void> _mensaje(String title) async {
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
                            color: Colores.naranja),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        '¿Desea cerrar la sesion de su cuenta?',
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 250,
                        child: RaisedButton(
                          color: Colors.redAccent,
                          onPressed: () async{
                            logout();
                          },
                          child: Text(
                            'Cerrar sesion',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'),
                        ),
                      )
                    ],
                  )),
            ),
          );
        },
      );
    }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('login',false);
    await prefs.setString('id','');
    await prefs.setString('nombre','');
    await prefs.setString('correo','');
    await prefs.setString('clave','');
    login =  false;
    robots = [];
    inversores = [];
    activos = [];
    datosUsuario = Usuario();
    Navigator.of(context)
        .pushNamed('/Login')
        .then((value) => setState(() {
      busqueda = true;
    }));
  }
}

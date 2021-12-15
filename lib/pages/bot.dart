import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoe/constants/themes.dart';
import 'package:zoe/database/request.dart';
import 'package:zoe/objects/inversor.dart';
import 'package:zoe/objects/robot.dart';

import '../globals.dart';

class Bot extends StatefulWidget {
  final int index;
  Bot({required this.index});
  _BotState createState() => _BotState();
}

class _BotState extends State<Bot> {

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(robots[widget.index].nombre),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fecha de inicio: ',
                style: TextStyle(
                  color: Colores.gris
                ),
                ),
                Text(robots[widget.index].inicio.day.toString()+
                '/'+
                    robots[widget.index].inicio.month.toString()+
                    '/'+
                    robots[widget.index].inicio.year.toString(),
                  style: TextStyle(
                      color: Colores.gris
                  ),
                ),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Inversion total: ',
                  style: TextStyle(
                      color: Colores.gris
                  ),),
                Text(activos[widget.index].inversion.toString(),
                  style: TextStyle(
                      color: Colores.gris
                  ),),
              ],),
            Divider(
              color: Colores.gris,
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,10),
                child: Text(
                  'Pago del robot',
                  style: TextStyle(
                      color: Colores.amarillo,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _builder(),
            if(robotFromJson(activos[widget.index].informacion.toString()).gradual)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Devolucion',
                    style: TextStyle(
                        color: Colores.gris
                    ),),
                  Text(activos[widget.index].inversion!
                      .toString(),
                    style: TextStyle(
                        color: Colores.gris
                    ),),
                ],
              ),
            Divider(
              color: Colores.gris,
              height: 5,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,10,0,10),
                      child: Text(
                        'Pagos a inversores ',
                        style: TextStyle(
                            color: Colores.amarillo,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  mesesRestantes(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex:5,
                    child: Text('')),
                Expanded(
                    flex:3,
                    child: Text('Mes',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colores.azul,
                        fontWeight: FontWeight.bold
                    ),)),
                Expanded(
                    flex:3,
                    child: Text('Total',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colores.azul,
                          fontWeight: FontWeight.bold
                      ),)),
                Expanded(
                  flex:3,
                  child: Text('Comision',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colores.azul,
                        fontWeight: FontWeight.bold
                    ),),),
              ],
            ),
            _builderInversores(),
            Divider(
              color: Colores.gris,
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Comision: ',
                  style: TextStyle(
                      color: Colores.gris
                  ),),
                Text(activos[widget.index].comision.toString(),
                  style: TextStyle(
                      color: Colores.gris
                  ),),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Devuelve inversion inicial',
                    style: TextStyle(
                        color: Colores.gris
                    ),),
                  Text(robotFromJson(activos[widget.index].informacion.toString()).gradual?
                  'Si':'No',
                    style: TextStyle(
                        color: Colores.gris
                    ),),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total a cobrar: ',
                  style: TextStyle(
                      color: Colores.amarillo,
                    fontWeight: FontWeight.bold
                  ),),
                Text(activos[widget.index].cobrar.toString(),
                  style: TextStyle(
                      color: Colores.amarillo,
                    fontWeight: FontWeight.bold
                  ),),
              ],),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: 250,
                child: RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () async{
                    _mensaje(robots[widget.index].nombre);
                  },
                  child: Text(
                    'Eliminar robot',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                      '¿Seguro desea eliminar este robot?',
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 250,
                      child: RaisedButton(
                        color: Colors.redAccent,
                        onPressed: () async{
                          Navigator.pop(context);
                          //print('se borra robot: '+ activos[widget.index].id.toString());
                          await BorrarRobot(activos[widget.index].id.toString())
                          .then((value) => continuar(value));
                        },
                        child: Text(
                          'Eliminar',
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

  void showInSnackBar(String value) {
    _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value)));
  }

  void continuar(String value){
    if(value == "1"){
      Navigator.pop(context);
    }else{
      showInSnackBar('Error al borrar');
    }
  }

  Widget _builder() {
    Robot robot = robots[widget.index];
    List<Inversor> _inversores =
        inversorFromJson(activos[widget.index].inversores.toString());
    double meses = robot.duracion;
    return ListView.builder(
      shrinkWrap: true,
        itemCount: meses.toInt(),
        itemBuilder: (context, index) {
        Robot r = robotFromJson(activos[widget.index].informacion.toString());
        int porcentaje = 0;
        if(r.gradual){
          porcentaje = r.gInicial + (r.gAumento * index);
        }
          return r.gradual?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Text(_mes(index, robot),
                  style: TextStyle(
                      color: Colores.gris
                  ),),
              ),
              Expanded(
                flex: 1,
                child: Text('('+porcentaje.toString()+'%)',
                  style: TextStyle(
                      color: Colores.gris
                  ),),
              ),
              Expanded(
                flex: 1,
                child: Text((double.parse(activos[widget.index].inversion!)*porcentaje/100)
                    .toStringAsFixed(1),
                  style: TextStyle(
                      color: Colores.gris
                  ),),
              ),
            ],
          ):
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_mes(index, robot),
                style: TextStyle(
                    color: Colores.gris
                ),),
              Text((double.parse(activos[widget.index].cobrar!) / meses)
                  .toStringAsFixed(1),
                style: TextStyle(
                    color: Colores.gris
                ),),
            ],
          );
        });
  }

  Widget _builderInversores() {
    Robot robot = robots[widget.index];
    List<Inversor> _inversores =
    inversorFromJson(activos[widget.index].inversores.toString());
    double meses = robot.duracion;
    return ListView.builder(
      shrinkWrap: true,
        itemCount: _inversores.length,
        itemBuilder: (context, index) {
          double total = 0;
          double totalCobrar = 0;
          double comision = 0;
          if(_inversores[index].monto!>0) {
            comision = (_inversores[index].monto! * _inversores[index].comision!) /100;
            totalCobrar = (_inversores[index].monto!-comision) + ((_inversores[index].monto! * robot.pago)/100);
            total = totalCobrar / meses;
            //print('comision $comision > total a cobrar $totalCobrar > total $total');
          }else{
            totalCobrar = _inversores[index].monto! + ((_inversores[index].monto! * robot.pago)/100);
            total = totalCobrar / meses;
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex:5,
                      child: Text(_inversores[index].nombre.toString(),
                        style: TextStyle(
                            color: Colores.gris
                        ),),),
                  Expanded(
                      flex:3,
                      child: Text(total.toStringAsFixed(1),
                        style: TextStyle(
                            color: Colores.gris
                        ),),),
                  Expanded(
                      flex:3,
                      child: Text(totalCobrar.toStringAsFixed(1),
                        style: TextStyle(
                            color: Colores.gris
                        ),),),
                  Expanded(
                    flex:3,
                    child: Text(comision.toStringAsFixed(1),
                      style: TextStyle(
                          color: Colores.gris
                      ),),),
                ],
              ),
            ],
          );
        });
  }

  String _mes(int index, Robot robot) {
    int i = robot.inicio.month + 1;
    if (i + index > 12) {
      i = (i + index) - 12;
    } else {
      i = i + index;
    }
    String m = '';
    switch (i) {
      case 1:
        m = 'Enero';
        break;
      case 2:
        m = 'Febrero';
        break;
      case 3:
        m = 'Marzo';
        break;
      case 4:
        m = 'Abril';
        break;
      case 5:
        m = 'Mayo';
        break;
      case 6:
        m = 'Junio';
        break;
      case 7:
        m = 'Julio';
        break;
      case 8:
        m = 'Agosto';
        break;
      case 9:
        m = 'Septiembre';
        break;
      case 10:
        m = 'Octubre';
        break;
      case 11:
        m = 'Noviembre';
        break;
      case 12:
        m = 'Diciembre';
        break;
    }
    return m;
  }

  Widget mesesRestantes() {
    DateTime inicio = robots[widget.index].inicio;
    int dias =  DateTime.now().difference(inicio).inDays;
    //print('dias: $dias');
    double t = dias/30;
    if(t<0){
      return Text(' 0/' + robots[widget.index].duracion.toStringAsFixed(0),
        style: TextStyle(
          fontWeight: FontWeight.bold,
            color: Colores.amarillo
        ),);
    }
    else{
      return Text(t.toStringAsFixed(0)+'/'+ robots[widget.index].duracion.toStringAsFixed(0),
      style: TextStyle(
          fontWeight: FontWeight.bold,
        color: Colores.amarillo
      ),);
    }
  }

  // Widget _inversion() {
  //   _inversionTotal = 0;
  //   inversores.forEach((element) {
  //     _inversionTotal = _inversionTotal + element.monto!;
  //   });
  //   return Text(_inversionTotal.toString());
  // }
  //
  // Widget _comision() {
  //   double c = 0;
  //   inversores.forEach((element) {
  //     if (element.comision! > 0) {
  //       double total = (element.monto! + (element.monto! * pago) / 100);
  //       c = c + ((total * element.comision!) / 100);
  //     }
  //   });
  //
  //   _comisionTotal = c;
  //   return Text(_comisionTotal.toString());
  // }
  //
  // Widget _totalCobrar() {
  //   double total = (_inversionTotal + (_inversionTotal * pago) / 100);
  //
  //   if (devuelveInversion) {
  //     _cobrarTotal = total + _inversionTotal;
  //   } else {
  //     _cobrarTotal = total;
  //   }
  //   return Text(
  //     _cobrarTotal.toString(),
  //     style: TextStyle(fontSize: 18),
  //   );
  // }
  //
  // Widget _totalPagar() {
  //   double total = _cobrarTotal - _comisionTotal;
  //
  //   if (devuelveInversion) {
  //     _cobrarTotal = total + _inversionTotal;
  //   } else {
  //     _cobrarTotal = total;
  //   }
  //
  //   return Text(
  //     total.toString(),
  //     style: TextStyle(fontSize: 18),
  //   );
  // }

  // Future<void> _Inversor() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: SingleChildScrollView(
  //           child: Form(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   const Text(
  //                     'Nuevo inversor',
  //                     style: TextStyle(fontSize: 20),
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   TextFormField(
  //                     controller: nombreController,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Nombre',
  //                       enabledBorder: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       focusedBorder: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       border: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                     ),
  //                   ),
  //                   TextFormField(
  //                     controller: montoController,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Monto',
  //                       enabledBorder: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       focusedBorder: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       border: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                     ),
  //                   ),
  //                   TextFormField(
  //                     controller: comisionController,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Comision',
  //                       enabledBorder: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       focusedBorder: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       border: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                     ),
  //                   ),
  //                   TextFormField(
  //                     controller: telefonoController,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Telefono',
  //                       enabledBorder: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       focusedBorder: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       border: UnderlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 20,
  //                   ),
  //                   RaisedButton(
  //                     color: Theme.of(context).primaryColor,
  //                     onPressed: () {
  //                       inversores.add(Inversor(
  //                           nombre: nombreController.value.text,
  //                           monto: double.parse(montoController.value.text),
  //                           comision: double.parse(comisionController.value.text),
  //                           telefono: telefonoController.value.text));
  //                       nombreController.clear();
  //                       montoController.clear();
  //                       comisionController.clear();
  //                       telefonoController.clear();
  //                       Navigator.pop(context);
  //                       setState(() {});
  //                     },
  //                     child: Text(
  //                       'Agregar',
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ),
  //                   RaisedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text('Cancelar'),
  //                   )
  //                 ],
  //               )),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _itemInversor(int index) {
  //   Widget item = Row(
  //     children: <Widget>[
  //       Expanded(
  //         flex: 3,
  //         child: Container(child: Text(inversores[index].nombre!)),
  //       ),
  //       SizedBox(
  //         width: 10,
  //       ),
  //       Expanded(
  //         flex: 3,
  //         child: Container(child: Text(inversores[index].monto.toString())),
  //       ),
  //       SizedBox(
  //         width: 10,
  //       ),
  //       Expanded(
  //         flex: 1,
  //         child: Container(child: Text(inversores[index].comision.toString())),
  //       ),
  //       Text('%'),
  //       if (editar)
  //         Expanded(
  //             flex: 1,
  //             child: IconButton(
  //                 onPressed: () {
  //                   inversores.removeAt(index);
  //                   setState(() {});
  //                 },
  //                 icon: const Icon(
  //                   Icons.remove_circle,
  //                   color: Colors.red,
  //                 )))
  //     ],
  //   );
  //   return item;
  // }
}

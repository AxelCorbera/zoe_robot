import 'package:flutter/material.dart';
import 'package:zoe/constants/themes.dart';
import 'package:zoe/database/request.dart';
import 'package:zoe/objects/inversor.dart';
import 'package:zoe/objects/robot.dart';

import '../globals.dart';

class Add_Bot extends StatefulWidget {
  @override
  _Add_BotState createState() => _Add_BotState();
}

class _Add_BotState extends State<Add_Bot> {
  bool busqueda = false;
  bool editar = false;
  bool gradual = false;
  bool autoinvertir = false;
  int gInicial = 0;
  int gAumento = 0;
  double meses = 1;
  DateTime _fecha = DateTime(2000, 10, 10);
  String nombre = '';
  int pago = 0;
  bool devuelveInversion = false;
  double _comisionTotal = 0;
  double _cobrarTotal = 0;
  double _inversionTotal = 0;
  double _pagarTotal = 0;
  List<Inversor> inversores = [];
  final nombreController = TextEditingController();
  final montoController = TextEditingController();
  final comisionController = TextEditingController();
  final telefonoController = TextEditingController();
  GlobalKey<FormState> _keyForm = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo robot"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Form(
              key: _keyForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nombre del robot',
                        style: TextStyle(
                            color: Colores.naranja,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      nombre = value;
                    },
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty)
                        return 'Debes escribir un nombre';
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pago del robot',
                        style: TextStyle(
                            color: Colores.naranja,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            'Fecha de inicio',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          )),
                      Expanded(
                        flex: 2,
                        child: RaisedButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime(2030))
                                .then((date) {
                              setState(() {
                                _fecha = date!;
                              });
                            });
                          },
                          child: Text(_fecha == DateTime(2000, 10, 10)
                              ? 'Seleccionar'
                              : _fecha.day.toString() +
                                  '/' +
                                  _fecha.month.toString() +
                                  '/' +
                                  _fecha.year.toString(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            'Duración',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              meses = double.parse(value);
                            },
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty)
                                return 'Completar';
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ' meses',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            'Pago',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              pago = int.parse(value);
                              setState(() {});
                            },
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty)
                                return 'Completar';
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              ' %',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            'Pago gradual',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Switch(
                              activeTrackColor:
                              Theme.of(context).secondaryHeaderColor,
                              activeColor: Colors.white,
                              value: gradual,
                              onChanged: (value) {
                                setState(() {
                                  gradual = value;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  if(gradual)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              'Inicial',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                gInicial = int.parse(value);
                                setState(() {});
                              },
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty)
                                  return 'Completar';
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                ' %',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                ),
                              )),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              'Aumento',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                gAumento = int.parse(value);
                                setState(() {});
                              },
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty)
                                  return 'Completar';
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                ' %',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                ),
                              )),
                        )
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            'Devuelve inversión inicial',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Switch(
                              activeTrackColor:
                                  Theme.of(context).secondaryHeaderColor,
                              activeColor: Colors.white,
                              value: devuelveInversion,
                              onChanged: (value) {
                                setState(() {
                                  devuelveInversion = value;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 5,
                    color: Colors.grey[700],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Inversores',
                            style: TextStyle(
                                color: Colores.naranja,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _Inversor();
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Nombre',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 13),
                        ),
                      ),
                      Expanded(child: Text('Monto',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 13),)),
                      Expanded(child: Text('Comisión',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 13),)),
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: inversores.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: _itemInversor(index),
                            ),
                            // Container(
                            //   child: IconButton(onPressed: (){
                            //     inversores.remove(inversores[index]);
                            //     setState(() {
                            //
                            //     });
                            //   }, icon: Icon(Icons.remove_circle,color: Colors.red,)),
                            // ),
                          ],
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: const Divider(
                      height: 15,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('Inversion',
                              style: TextStyle(
                                  color: Colores.gris,
                                  fontSize: 13)),
                        ),
                        Container(child: _inversion()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('Devolucion',
                              style: TextStyle(
                                  color: Colores.gris,
                                  fontSize: 13)),
                        ),
                        Container(
                            child: Text(devuelveInversion ? 'Si' : 'Incluida',
                              style: TextStyle(fontSize: 13,
                                  color: Colores.gris),)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Total a cobrar:',
                            style: TextStyle(fontSize: 15,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Container(child: _totalCobrar()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('Comisión',
                              style: TextStyle(
                                  color: Colores.gris,
                                  fontSize: 13)),
                        ),
                        Container(child: _comision()),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Total a pagar:',
                          style: TextStyle(fontSize: 15,
                          color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Container(child: _totalPagar()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: const Divider(
                      height: 10,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RaisedButton(
                      onPressed: inversores.isNotEmpty
                          ? () {
                        if(_keyForm.currentState!.validate()){
                              int buscarId = 0;
                              robots.forEach((element) {
                                if (element.id == buscarId) {
                                  buscarId++;
                                }
                              });
                              Robot r =
                                  Robot(buscarId, nombre, meses, pago, _fecha, gradual,
                                  gInicial, gAumento, devuelveInversion);
                              print(r.toJson());
                              CargarRobot(r, inversores, _inversionTotal,
                                  _comisionTotal, _pagarTotal, _cobrarTotal);
                              Navigator.pop(context);
                            }}
                          : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: inversores.isNotEmpty?
                          Colores.amarillo:null,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
                                'Crear robot',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Widget _inversion() {
    _inversionTotal = 0;
    inversores.forEach((element) {
      _inversionTotal = _inversionTotal + element.monto!;
    });
    return Text(_inversionTotal.toStringAsFixed(1),
      style: TextStyle(fontSize: 13,
          color: Colores.gris),);
  }

  Widget _comision() {
    double c = 0;
    inversores.forEach((element) {
      if (element.comision! > 0) {
        double total = (element.monto! + (element.monto! * pago) / 100);
        c = c + ((total * element.comision!) / 100);
      }
    });

    _comisionTotal = c;
    return Text(_comisionTotal.toStringAsFixed(1),
      style: TextStyle(fontSize: 13,
          color: Colores.gris),);
  }

  Widget _totalCobrar() {
    double total = _inversionTotal + ((_inversionTotal * pago) / 100);

    if (devuelveInversion) {
      _cobrarTotal = total + _inversionTotal;
    } else {
      _cobrarTotal = total;
    }
    return Text(
      _cobrarTotal.toStringAsFixed(1),
      style: TextStyle(fontSize: 15,
          color: Theme.of(context).primaryColor),
    );
  }

  Widget _totalPagar() {
    _pagarTotal = _cobrarTotal - _comisionTotal;

    return Text(
      _pagarTotal.toStringAsFixed(1),
      style: TextStyle(fontSize: 15,
          color: Theme.of(context).primaryColor),
    );
  }

  Future<void> _Inversor() async {
    GlobalKey<FormState> _keyForm1 = GlobalKey();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return StatefulBuilder(builder: (context, setState){
          return AlertDialog(
            content: SingleChildScrollView(
              child: Form(
                key: _keyForm1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nuevo inversor',
                            style: TextStyle(
                                color: Colores.naranja, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('Soy yo'),
                        Switch(
                            activeTrackColor:
                            Theme.of(context).secondaryHeaderColor,
                            activeColor: Colors.white,
                            value: autoinvertir, onChanged: (value){
                          if(value){
                            nombreController.text = '@';
                            comisionController.text = '0';
                            telefonoController.text = '0';
                          }else{
                            nombreController.text = '';
                            comisionController.text = '';
                            telefonoController.text = '';
                          }
                          setState((){
                            autoinvertir = value;
                          });
                        })
                      ],),
                      TextFormField(
                        enabled: autoinvertir? false:true,
                        controller: nombreController,
                        decoration: InputDecoration(
                          filled: autoinvertir? true:false,
                          fillColor: Colors.grey[300],
                          labelText: 'Nombre',
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Debes ingresar un nombre';
                          }
                        },
                      ),
                      TextFormField(
                        controller: montoController,
                        decoration: const InputDecoration(
                          labelText: 'Monto',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Debes ingresar un monto';
                          }
                        },
                      ),
                      TextFormField(
                        enabled: autoinvertir? false:true,
                        controller: comisionController,
                        decoration: InputDecoration(
                          filled: autoinvertir? true:false,
                          fillColor: Colors.grey[300],
                          labelText: 'Comision',
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      TextFormField(
                        enabled: autoinvertir? false:true,
                        controller: telefonoController,
                        decoration: InputDecoration(
                          filled: autoinvertir? true:false,
                          fillColor: Colors.grey[300],
                          labelText: 'Telefono',
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 250,
                        child: RaisedButton(
                          color: Theme.of(context).secondaryHeaderColor,
                          onPressed: () {
                            if(_keyForm1.currentState!.validate()) {
                              double m = 0;
                              if (comisionController.value.text.isNotEmpty) {
                                m = double.parse(comisionController.value.text);
                              }
                              String tel = '';
                              if (telefonoController.value.text.isNotEmpty) {
                                tel = telefonoController.value.text;
                              }

                              inversores.add(Inversor(
                                  nombre: nombreController.value.text,
                                  monto: double.parse(
                                      montoController.value.text),
                                  comision: m,
                                  telefono: tel));
                              autoinvertir = false;
                              nombreController.clear();
                              montoController.clear();
                              comisionController.clear();
                              telefonoController.clear();
                              Navigator.pop(context);
                              _actualizar();
                            }
                          },
                          child: Text(
                            'Agregar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: RaisedButton(
                          onPressed: () {
                            autoinvertir =false;
                            nombreController.clear();
                            montoController.clear();
                            comisionController.clear();
                            telefonoController.clear();
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'),
                        ),
                      )
                    ],
                  )),
            ),
          );
        });
      },
    );
  }

  Widget _itemInversor(int index) {
    Widget item = Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(child: Text(inversores[index].nombre!)),
          ),
          Expanded(
            child: Container(child: Text(inversores[index].monto.toString())),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: Text(inversores[index].comision.toString()+'%')),
                  Container(
                    width: 47,
                    height: 50,
                    child: IconButton(
                        onPressed: () {
                          inversores.removeAt(index);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        )),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    return item;
  }

  void _actualizar() {
    setState(() {});
  }
}

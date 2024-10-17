import 'dart:math';

import 'package:app_negocio/controlador/acciones_productos.dart';
import 'package:app_negocio/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ProductosAlmacenview extends StatefulWidget {
  final String tittle;
  final Color color;

  ProductosAlmacenview({
    Key? key,
    required this.tittle,
    required this.color,
  }) : super(key: key);

  @override
  _ProductosAlmacenviewState createState() => _ProductosAlmacenviewState();
}

class _ProductosAlmacenviewState extends State<ProductosAlmacenview> {
  final acciones_productos productos = acciones_productos();
  late TextEditingController idController;
  late TextEditingController stockController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    stockController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double v = 25;
    bool b = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.tittle),
        titleTextStyle: TextStyle(
          fontSize: 32,
        ),
        backgroundColor: widget.color,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: productos.productos.length,
            itemBuilder: (context, index) {
              var producto = productos.verProductos();
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 184, 125, 203),
                  child: Text(producto[index].id),
                ),
                title: Text(
                  producto[index].nombre +
                      '\n\$' +
                      producto[index].precio +
                      '  Stock: ' +
                      producto[index].lote,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        idController.text = producto[index].id;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      productos.mostrarInfo(
                                          id: idController.text),
                                      style: TextStyle(
                                        fontSize: 19,
                                      ),
                                    ),
                                    Text('Stock: ' + producto[index].lote),
                                    TextField(
                                      controller: stockController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Cantidad',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            child: Text('Restar'),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 208, 140, 135),
                                              ),
                                            ),
                                            onPressed: () {
                                              b = false;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            child: Text('Sumar'),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 171, 217, 172),
                                              ),
                                            ),
                                            onPressed: () {
                                              b = true;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      child: Text('Guardar'),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          const Color.fromARGB(
                                              255, 119, 178, 226),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (int.parse(stockController.text) >
                                            0) {
                                          await productos.modificar(
                                            id: idController.text,
                                            clave: 'lote',
                                            cambio: stockController.text,
                                            hacer: b,
                                          );
                                        }
                                        stockController.clear();
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

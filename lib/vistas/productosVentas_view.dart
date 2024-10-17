import 'package:app_negocio/controlador/acciones_venta.dart';
import 'package:app_negocio/modelo/productos.dart';
import 'package:app_negocio/widgets/custom_button.dart';
import 'package:app_negocio/widgets/search_producto.dart';
import 'package:flutter/material.dart';

class ProductosVentasview extends StatefulWidget {
  final String tittle;
  final Color color;

  ProductosVentasview({
    Key? key,
    required this.tittle,
    required this.color,
  }) : super(key: key);

  @override
  _ProductosVentasviewState createState() => _ProductosVentasviewState();
}

class _ProductosVentasviewState extends State<ProductosVentasview> {
  late TextEditingController reciboController;
  late TextEditingController cambioController;
  late TextEditingController idController;
  late TextEditingController stockController;
  late AccionesVenta acciones = AccionesVenta();

  Color barrita = Color.fromARGB(255, 79, 122, 182);
  Color boton1 = Color.fromRGBO(191, 230, 191, 1);
  Color boton2 = Color.fromRGBO(216, 141, 156, 1);

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    stockController = TextEditingController();
    reciboController = TextEditingController();
    cambioController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double v = 25;
    Cproducto? result;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.tittle,
                    style: const TextStyle(
                      fontSize: 33,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                result ??= await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Myejemplo(
                      color: widget.color,
                      items: acciones.listashow,
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    acciones.agregar(result!, 1);
                  });
                  debugPrint('${result!.nombre} resultado');
                } else {
                  debugPrint('No se seleccionó ningún resultado');
                }
              },
              icon:
                  const Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
        backgroundColor: widget.color,
      ),
      body: Stack(
        children: [
          Container(
            child: ListView.builder(
              itemCount: acciones.lista.length,
              itemBuilder: (context, index) {
                final accion = acciones.lista[index];
                return Card(
                  child: SingleChildScrollView(
                    child: ListTile(
                      title: Text(accion.idproducto.nombre),
                      subtitle: Text('\nTotal: ${accion.total}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                acciones.eliminar(accion.idproducto, 1);
                              });
                            },
                          ),
                          Text(accion.cantidad),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              acciones.agregar(accion.idproducto, 1);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: AlignmentDirectional.topStart,
            margin: const EdgeInsets.only(top: 480.0),
            child: Column(
              children: [
                Container(
                  alignment:
                      AlignmentDirectional.topCenter, // Centra el contenedor
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centra el contenido
                      children: [
                        Icon(
                          Icons.point_of_sale,
                          size: 45.0,
                          color: const Color.fromARGB(255, 71, 184, 40),
                        ),
                        SizedBox(
                            width: 5.0), // Espacio entre el icono y el texto
                        Expanded(
                          child: Text(
                            'Subtotal en pesos: ${acciones.subtotalVenta()} \nTotal en pesos: ${acciones.total()}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center, // Centra el texto
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: CustomButton(
                        name: 'Guardar',
                        color: boton1,
                        txcolor: Colors.black,
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  height: 400,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          enabled: false,
                                          controller: TextEditingController(
                                              text:
                                                  acciones.total().toString()),
                                          decoration: const InputDecoration(
                                            labelText: 'Total',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: reciboController,
                                          decoration: const InputDecoration(
                                            labelText: 'Recibo',
                                            hintText: 'Recibo',
                                          ),
                                          onEditingComplete: () {
                                            double cambio = double.parse(
                                                    reciboController.text) -
                                                double.parse(acciones
                                                    .total()
                                                    .toString());
                                            String roundedCambio =
                                                cambio.toStringAsFixed(2);
                                            cambioController.text =
                                                roundedCambio;
                                          },
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          enabled: false,
                                          controller: cambioController,
                                          decoration: const InputDecoration(
                                            labelText: 'Cambio',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomButton(
                                          name: 'Guardar',
                                          color: const Color.fromARGB(
                                              255, 247, 178, 32),
                                          txcolor: Colors.black,
                                          onPressed: () {
                                            acciones.guardar(
                                                reciboController.text,
                                                cambioController.text);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          setState(() {
                            acciones = AccionesVenta();
                            acciones.limpiar();
                            reciboController.clear();
                            cambioController.clear();
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: CustomButton(
                        name: 'Cancelar',
                        color: boton2,
                        txcolor: Colors.black,
                        onPressed: () {
                          acciones.lista.clear();
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: barrita,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

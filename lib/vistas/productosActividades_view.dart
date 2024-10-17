import 'package:app_negocio/controlador/acciones_productos.dart';
import 'package:app_negocio/widgets/Combox_lista.dart';
import 'package:app_negocio/widgets/custom_button.dart';
import 'package:app_negocio/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductosAccionesview extends StatefulWidget {
  final String tittle;
  final Color color;

  ProductosAccionesview({
    Key? key,
    required this.tittle,
    required this.color,
  }) : super(key: key);

  @override
  _ProductosAccionesviewState createState() => _ProductosAccionesviewState();
}

class _ProductosAccionesviewState extends State<ProductosAccionesview> {
  final acciones_productos productos = acciones_productos();
  late TextEditingController idController;
  late TextEditingController nombreController;
  late TextEditingController precioController;
  late TextEditingController descripcionController;

  final List<String> categorias = [
    'Frutas y Verduras',
    'Carnes',
    'Lacteos',
    'Higiene',
    'Bebidas',
    'Botanas',
    'Limpieza',
    'Otros',
  ];
  String? seleccionado;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    nombreController = TextEditingController();
    precioController = TextEditingController();
    descripcionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double v = 25;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.tittle),
        titleTextStyle: TextStyle(
          fontSize: 30,
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
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                productos.mostrarDescripcion(
                                    id: producto[index].id),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 184, 125, 203),
                  child: Text(producto[index].id),
                ),
                title: Text(
                  producto[index].nombre + '\n\$' + producto[index].precio,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        idController.text = producto[index].id;
                        nombreController.text = producto[index].nombre;
                        precioController.text = producto[index].precio;
                        descripcionController.text =
                            producto[index].descripcion;
                        String? seleccionado = producto[index].categoria;

                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'ID: ' + idController.text,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Nombre:',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      TextField(
                                        controller: nombreController,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            constraints: BoxConstraints(
                                              maxWidth: 150,
                                            )),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Precio:\$',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      TextField(
                                        controller: precioController,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            constraints: BoxConstraints(
                                              maxWidth: 150,
                                            )),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Categoria:    ' +
                                        seleccionado +
                                        '\nDescripcion: ' +
                                        descripcionController.text,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Center(
                                    child: CustomButton(
                                      onPressed: () async {
                                        double? numero = double.tryParse(
                                            precioController.text);
                                        if (numero != null) {
                                          print(productos.productos.toMap());
                                          await productos.modificar(
                                              id: idController.text,
                                              clave: 'nombre',
                                              cambio: nombreController.text,
                                              hacer: true);
                                          print(productos.productos.toMap());
                                          await productos.modificar(
                                            id: idController.text,
                                            clave: 'precio',
                                            cambio: numero.toString(),
                                            hacer: true,
                                          );
                                          print(productos.productos.toMap());
                                          producto = productos.verProductos();
                                        }
                                        ;
                                        idController.text = '';
                                        nombreController.text = '';
                                        precioController.text = '';
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      name: 'Guardar',
                                      color: widget.color,
                                      txcolor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ConfirmationDialog(
                              texto: "¿Está seguro de que desea borrar " +
                                  productos.mostrar(id: producto[index].id),
                              onConfirmed: () {
                                productos.eliminarProducto(
                                    id: producto[index].id);
                                Navigator.of(context).pop;
                                setState(() {});
                              },
                              titulo: 'Confirmar',
                              cancelar: 'Cancelar',
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: CircleAvatar(
              maxRadius: v,
              backgroundColor: const Color.fromARGB(255, 169, 166, 158),
              child: IconButton(
                iconSize: v,
                icon: Icon(Icons.add),
                onPressed: () {
                  idController.text = '';
                  nombreController.text = '';
                  precioController.text = '';
                  descripcionController.text = '';
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Agregar Producto',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                TextField(
                                  controller: idController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Ingrese el codigo',
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: nombreController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Ingrese el nombre',
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: precioController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Ingrese el precio',
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CategoriaDropdown(
                                  categorias: categorias,
                                  onCategoriaSeleccionada: (String? value) {
                                    seleccionado = value;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: descripcionController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Descripción del producto',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                      )),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(100),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: CustomButton(
                                    onPressed: () async {
                                      await productos.agregarProducto(
                                        id: idController.text,
                                        nombre: nombreController.text,
                                        precio: precioController.text,
                                        categoria: seleccionado!,
                                        lote: '0',
                                        descripcion: descripcionController.text,
                                      );
                                      setState(() {
                                        idController.text = '';
                                        nombreController.text = '';
                                        precioController.text = '';
                                        descripcionController.text = '';
                                      });
                                      Navigator.pop(context);
                                    },
                                    name: 'Guardar',
                                    color: widget.color,
                                    txcolor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:app_negocio/controlador/acciones_venta.dart';
import 'package:app_negocio/modelo/lista_ventas.dart';
import 'package:app_negocio/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;

class Registroview extends StatelessWidget {
  final String tittle;
  final Color color;

  Registroview({
    Key? key,
    required this.tittle,
    required this.color,
  });

  AccionesVenta acciones = AccionesVenta();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(tittle),
        titleTextStyle: TextStyle(
          fontSize: 30,
        ),
        backgroundColor: color,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: acciones.getListaVenta().length,
            itemBuilder: (context, index) {
              listaVentas lista = acciones.getListaVenta()[index];
              return Card(
                child: SingleChildScrollView(
                  child: ListTile(
                    title: Text(lista.id),
                    subtitle: Text('${lista.fecha} ${lista.hora}'),
                    trailing: Text('Total:  \$${lista.total}'),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmación'),
                            content: Text('¿Deseas abrir el archivo PDF?'),
                            actions: [
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Abrir'),
                                onPressed: () async {
                                  final pdf = pw.Document();

                                  pdf.addPage(
                                    pw.Page(
                                      build: (pw.Context context) {
                                        final lista = acciones.getListaVenta()[
                                            index]; // Obtener el elemento seleccionado
                                        return pw.Center(
                                          child: pw.Column(
                                            children: [
                                              pw.Container(
                                                margin: pw.EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: pw.Column(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text('ID:' + lista.id),
                                                    pw.Text('Fecha: ' +
                                                        lista.fecha),
                                                    pw.Text(
                                                        'Hora: ' + lista.hora),
                                                    pw.Text('Productos: \n' +
                                                        lista.productos
                                                            .split('[')[1]
                                                            .split(']')[0]
                                                            .replaceAll(
                                                                ',', ' ')
                                                            .split('}')
                                                            .join('\n')
                                                            .replaceAll(
                                                                '{', ' - ')
                                                            .replaceAll(
                                                                '"', ' ')),
                                                    pw.Text('Subtotal: \$' +
                                                        lista.subtotal),
                                                    pw.Text(
                                                      'Iva: \$' +
                                                          (double.parse(lista
                                                                      .total) -
                                                                  double.parse(lista
                                                                      .subtotal))
                                                              .toString(),
                                                    ),
                                                    pw.Text('Total: \$' +
                                                        lista.total),
                                                    pw.Text('Recibo: \$' +
                                                        lista.recibo),
                                                    pw.Text('Cambio: \$' +
                                                        lista.cambio),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );

                                  final output = await getTemporaryDirectory();
                                  final file =
                                      File('${output.path}/example.pdf');

                                  await file.writeAsBytes(await pdf.save());

                                  OpenFile.open(file.path);

                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

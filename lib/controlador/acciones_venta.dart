import 'dart:convert';
import 'dart:math';

import 'package:app_negocio/controlador/acciones_productos.dart';
import 'package:app_negocio/modelo/lista_ventas.dart';
import 'package:app_negocio/modelo/productos.dart';
import 'package:app_negocio/modelo/venta_productos.dart';
import 'package:hive/hive.dart';

class AccionesVenta {
  final productos = Hive.box('productos');
  List<VentaProductos> lista = [];
  List<Cproducto> listashow = [];

  AccionesVenta() {
    lista = [];
    for (int i = 0; i < productos.length; i++) {
      if (int.parse(productos.getAt(i)['lote']) > 0) {
        String id = productos.getAt(i)['id'];
        String nombre = productos.getAt(i)['nombre'];
        String precio = productos.getAt(i)['precio'];
        String categoria = productos.getAt(i)['categoria'];
        String lote = productos.getAt(i)['lote'];
        String descripcion = productos.getAt(i)['descripcion'];
        listashow.add(Cproducto(
            id: id,
            nombre: nombre,
            precio: precio,
            categoria: categoria,
            lote: lote,
            descripcion: descripcion));
      }
    }
  }

  void agregar(Cproducto producto, int cantidad) {
    if (lista.isEmpty) {
      lista.add(VentaProductos(
          idproducto: producto,
          cantidad: cantidad.toString(),
          total: producto.precio));
      return;
    } else {
      for (int i = 0; i < lista.length; i++) {
        if (lista[i].idproducto.id == producto.id) {
          if ((int.parse(lista[i].cantidad) + cantidad) <=
              int.parse(producto.lote)) {
            lista[i].cantidad =
                (int.parse(lista[i].cantidad) + cantidad).toString();
            lista[i].total = (double.parse(lista[i].idproducto.precio) *
                    int.parse(lista[i].cantidad))
                .toString();

            return;
          } else {
            return;
          }
        }
      }
      lista.add(VentaProductos(
          idproducto: producto,
          cantidad: cantidad.toString(),
          total: (double.parse(producto.precio) * cantidad).toString()));
    }
  }

  void eliminar(Cproducto producto, int eliminar) {
    for (int i = 0; i < lista.length; i++) {
      if (lista[i].idproducto.id == producto.id) {
        if ((int.parse(lista[i].cantidad) - eliminar) < 1) {
          lista.removeAt(i);
        } else {
          lista[i].cantidad =
              (int.parse(lista[i].cantidad) - eliminar).toString();
          lista[i].total = (double.parse(lista[i].idproducto.precio) *
                  int.parse(lista[i].cantidad))
              .toString();
        }
      }
    }
  }

  void guardar(String recibo, String cambio) async {
    var ventas = await Hive.openBox('ventas');
    String id = generarId().toString();
    print(lista.toList());
    ventas.put(id, {
      'Id': id,
      'Productos': lista
          .toList()
          .map((VentaProductos producto) => {
                'id': producto.idproducto.id,
                'nombre': producto.idproducto.nombre,
                'precio': producto.idproducto.precio,
                'cantidad': producto.cantidad,
                'total': producto.total,
              })
          .toList(),
      'Subtotal': subtotalVenta(),
      'Iva': iva(),
      'Total': total(),
      'Fecha': DateTime.now(),
      'Hora': DateTime.now(),
      'Recibo': recibo,
      'Cambio': cambio,
    });
    for (int i = 0; i < lista.length; i++) {
      for (int j = 0; j < productos.length; j++) {
        if (lista[i].idproducto.id == productos.getAt(j)['id']) {
          productos.putAt(j, {
            'id': productos.getAt(j)['id'],
            'nombre': productos.getAt(j)['nombre'],
            'precio': productos.getAt(j)['precio'],
            'categoria': productos.getAt(j)['categoria'],
            'lote': (int.parse(productos.getAt(j)['lote']) -
                    int.parse(lista[i].cantidad))
                .toString(),
            'descripcion': productos.getAt(j)['descripcion'],
          });
        }
      }
      ;
    }
    print(productos.toMap().toString());
    print(
      lista
          .toList()
          .map((VentaProductos producto) => {
                'id': producto.idproducto.id,
                'nombre': producto.idproducto.nombre,
                'precio': producto.idproducto.precio,
                'cantidad': producto.cantidad,
                'total': producto.total,
              })
          .toList(),
    );
    print(ventas.toMap().toString());
  }

  int generarId() {
    var ventas = Hive.box('ventas');
    int id;
    do {
      id = Random().nextInt(9000) +
          1000; // Genera un número aleatorio entre 1000 y 9999.
    } while (ventas.containsKey(id.toString()));
    return id;
  }

  String subtotalVenta() {
    double total = 0;
    for (int i = 0; i < lista.length; i++) {
      total += double.parse(lista[i].total);
      total = double.parse(total.toStringAsFixed(2));
    }
    return total.toString();
  }

  String iva() {
    double iva = double.parse(total()) - double.parse(subtotalVenta());
    iva = double.parse(iva.toStringAsFixed(2));
    return iva.toString();
  }

  String total() {
    double total =
        (double.parse(subtotalVenta()) * 0.16) + double.parse(subtotalVenta());
    total = double.parse(total.toStringAsFixed(2));
    return total.toString();
  }

  void limpiar() {
    lista.clear();
  }

  List<Cproducto> getLista() {
    return listashow;
  }

  List<listaVentas> getListaVenta() {
    var ventas = Hive.box('ventas');
    print(ventas.toMap().toString());
    if (ventas.isNotEmpty) {
      List<listaVentas> listaProductos = [];
      for (int i = 0; i < ventas.length; i++) {
        print(ventas.getAt(i)['Productos']);
        print(ventas.toMap().toString());
        listaProductos.add(listaVentas(
            id: ventas.getAt(i)['Id'],
            productos: jsonEncode(ventas.getAt(i)['Productos']),
            subtotal: ventas.getAt(i)['Subtotal'],
            iva: ventas.getAt(i)['Iva'],
            recibo: ventas.getAt(i)['Recibo'],
            cambio: ventas.getAt(i)['Cambio'],
            fecha: ventas.getAt(i)['Fecha'].toString().split(' ')[0],
            hora: ventas.getAt(i)['Hora'].toString().split(' ')[1],
            total: ventas.getAt(i)['Total']));
      }
      return listaProductos;
    }
    return [];
  }
}

import 'dart:ffi';
import 'package:app_negocio/modelo/productos.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class acciones_productos {
  var productos = Hive.box('productos');

  Future<void> modificar(
      {required String id,
      required String clave,
      required String cambio,
      required bool hacer}) async {
    if (clave == 'precio') {
      double? precioo = double.tryParse(cambio);
      if (precioo != null && precioo > 0) {
        cambio = precioo.toString();
      } else {
        return;
      }
    }

    if (clave == 'lote') {
      int? lote1 = int.tryParse(cambio);
      int? lote2 = int.tryParse(productos.get(id)['lote']);
      int? operacion;

      if (lote1 != null && lote2 != null) {
        if (hacer)
          cambio = (lote1 + lote2).toString();
        else {
          operacion = lote2 - lote1;
          if (operacion < 0) {
            cambio = '0';
          } else {
            cambio = operacion.toString();
          }
        }
      } else {
        return;
      }
    }

    Map<dynamic, dynamic> producto = productos.get(id);
    producto[clave] = cambio;

    await productos.put(id, producto);
    print(productos.get(id));
  }

  String agregarProducto({
    required String id,
    required String nombre,
    required String precio,
    required String categoria,
    required String lote,
    required String descripcion,
  }) {
    int? numero = int.tryParse(id);
    if (numero != null) {
      if (productos.containsKey(id)) {
        return 'Ya existe.';
      } else {
        double? precioo = double.tryParse(precio);
        if (precioo != null && precioo > 0) {
          precio = precioo.toString();
          if (descripcion.isEmpty) {
            descripcion = 'Sin descripcion';
          }
          productos.put(
            id,
            {
              'id': id,
              'nombre': nombre,
              'precio': precio,
              'categoria': categoria,
              'lote': lote,
              'descripcion': descripcion,
            },
          );
          return 'Agregado con exito.';
        } else {
          return 'No fue posible agregarlo...';
        }
      }
    } else {
      return 'Datos no validos, intentelo de nuevo...';
    }
  }

  String eliminarProducto({
    required String id,
  }) {
    if (productos.containsKey(id)) {
      productos.delete(id);
      return 'Eliminado con exito.';
    }
    return '';
  }

  String mostrar({required String id}) {
    String cadena = "";
    if (productos.containsKey(id)) {
      cadena = 'Producto \"' + productos.get(id)['nombre'];
    }
    return cadena;
  }

  String mostrarDescripcion({required String id}) {
    String cadena = "";
    if (productos.containsKey(id)) {
      cadena = 'Producto \:' +
          productos.get(id)['nombre'] +
          '\nPrecio: \$' +
          productos.get(id)['precio'] +
          '\nCategoria: ' +
          productos.get(id)['categoria'] +
          '\nDescripcion: ' +
          productos.get(id)['descripcion'] +
          '\nStock: ' +
          productos.get(id)['lote'];
    }
    return cadena;
  }

  String mostrarInfo({required String id}) {
    String cadena = "";
    if (productos.containsKey(id)) {
      cadena = 'Producto \:' +
          productos.get(id)['nombre'] +
          '\nPrecio: \$' +
          productos.get(id)['precio'] +
          '\nCategoria: ' +
          productos.get(id)['categoria'] +
          '\nDescripcion: ' +
          productos.get(id)['descripcion'];
    }
    return cadena;
  }

  List<Cproducto> verProductos() {
    if (productos.isNotEmpty) {
      List<Cproducto> listaProductos = [];
      for (var i = 0; i < productos.length; i++) {
        listaProductos.add(
          Cproducto(
            id: productos.getAt(i)['id'],
            nombre: productos.getAt(i)['nombre'],
            precio: productos.getAt(i)['precio'],
            categoria: productos.getAt(i)['categoria'],
            lote: productos.getAt(i)['lote'],
            descripcion: productos.getAt(i)['descripcion'],
          ),
        );
      }
      return listaProductos;
    }
    return [];
  }

  String ver() {
    String cadena = '';
    for (var i = 0; i < productos.length; i++) {
      cadena += productos.getAt(i).toString() + '\n';
      //162,352,472,721
    }
    return cadena;
  }
}

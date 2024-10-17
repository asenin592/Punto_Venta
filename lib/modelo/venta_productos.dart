import 'package:app_negocio/modelo/productos.dart';

class VentaProductos {
  Cproducto idproducto;
  String cantidad;
  String total;

  VentaProductos(
      {required this.idproducto, required this.cantidad, required this.total});

  List lista() {
    return [idproducto, cantidad, total];
  }
}

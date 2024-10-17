class listaVentas {
  String id;
  String productos;
  String subtotal;
  String iva;
  String total;
  String fecha;
  String hora;
  String recibo;
  String cambio;

  listaVentas(
      {required this.id,
      required this.productos,
      required this.subtotal,
      required this.iva,
      required this.total,
      required this.fecha,
      required this.hora,
      required this.recibo,
      required this.cambio});
}

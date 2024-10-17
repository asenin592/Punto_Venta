import 'dart:io';
import 'package:app_negocio/vistas/productosActividades_view.dart';
import 'package:app_negocio/vistas/productosAlmacen_view.dart';
import 'package:app_negocio/vistas/ProductosRegistros_view.dart';
import 'package:app_negocio/vistas/productosVentas_view.dart';
import 'package:app_negocio/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  Color botones = Color.fromARGB(255, 115, 193, 202);
  Color appbar = Color(0xFFD53302);
  Color ventas = Color(0xFF383F75);
  Color almacen = Color(0xFF383F75);
  Color productos = Color(0xFF383F75);
  Color registros = Color(0xFF383F75);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Punto de Venta',
          style: GoogleFonts.lato(
            // Reemplaza con el tipo de letra que prefieras
            textStyle: TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: appbar,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white.withOpacity(
                0.60), // Ajusta el valor de opacidad según tus necesidades
          ),
          Column(
            children: [
              Container(
                width: 350.0,
                height: 400.0,
                margin: EdgeInsets.all(
                    20.0), // Ajusta los márgenes según tus necesidades
                padding: EdgeInsets.all(
                    10.0), // Ajusta el espacio interno según tus necesidades
                color: Color.fromARGB(255, 255, 241, 236),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hola, Bienvenido/a mi primer punto de venta en flutter' +
                          '\n\n  Selecciona cualquier boton para comenzar.',
                      style: GoogleFonts.chilanka(
                        // Reemplaza con el tipo de letra que prefieras
                        textStyle: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0), // Espacio entre el texto y el icono
                    Icon(
                      Icons.menu_book_rounded,
                      size: 90.0,
                      color: const Color.fromARGB(255, 209, 21, 21),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    name: 'Ventas',
                    color: botones,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ProductosVentasview(
                            tittle: 'Ventas',
                            color: ventas,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(-1, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    txcolor: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomButton(
                    name: 'Registros',
                    color: botones,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ProductosAccionesview(
                            tittle: 'Registros',
                            color: registros,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    txcolor: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    name: 'Inventario',
                    color: botones,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ProductosAlmacenview(
                            tittle: 'Inventario',
                            color: almacen,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    txcolor: Colors.black,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  CustomButton(
                    name: 'Ticket',
                    color: botones,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Registroview(
                            tittle: 'Ticket',
                            color: productos,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    txcolor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

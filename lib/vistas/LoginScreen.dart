import 'package:app_negocio/vistas/home_view.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) {
    final String user = userController.text;
    final String password = passwordController.text;

    if (user == 'asenin592' && password == 'sonicdx10') {
      // Navegar a la pantalla principal si las credenciales son correctas
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
        backgroundColor: const Color.fromARGB(255, 198, 131, 209),
      ),
      body: Container(
        color: const Color.fromARGB(255, 159, 165, 211), // Fondo negro
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 100.0,
                color: Colors.white,
              ),
              SizedBox(
                  height: 20.0), // Espacio entre el icono y el campo de usuario
              TextField(
                controller: userController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30.0), // Espacio entre los campos
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text(
                  'Iniciar',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .white, // Cambiado a blanco para que el texto negro sea visible
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

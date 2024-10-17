import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ConfirmationDialog extends StatelessWidget {
  final String titulo;
  final String texto;
  final String cancelar;
 final Function onConfirmed;

  const ConfirmationDialog({Key? key, 
    required this.texto,
    required this.onConfirmed, 
    required this.titulo, 
    required this.cancelar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      content: Text(texto),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(cancelar),
          ),
        TextButton(
          onPressed: () {
            // Llama a la función de confirmación pasada como argumento
            onConfirmed();
            Navigator.of(context).pop();
          },
          child: Text("Aceptar"),
        ),
      ],
    );
  }
}
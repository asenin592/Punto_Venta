import 'package:flutter/material.dart';

class CategoriaDropdown extends StatefulWidget {
  final List<String> categorias;
  final ValueChanged<String?> onCategoriaSeleccionada;

  CategoriaDropdown(
      {required this.categorias, required this.onCategoriaSeleccionada});

  @override
  _CategoriaDropdownState createState() => _CategoriaDropdownState();
}

class _CategoriaDropdownState extends State<CategoriaDropdown> {
  String? seleccionado;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(10),
      isExpanded: true,
      hint: const Row(
        children: [
          Icon(
            Icons.list,
            size: 16,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              'Seleccione una categoria',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: widget.categorias
          .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      value: seleccionado,
      onChanged: (String? value) {
        setState(() {
          seleccionado = value;
        });
        widget.onCategoriaSeleccionada(value);
      },
    );
  }
}

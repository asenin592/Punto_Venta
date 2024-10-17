import 'package:app_negocio/modelo/productos.dart';
import 'package:flutter/material.dart';

class Myejemplo extends StatefulWidget {
  final List<Cproducto> items;
  final Color color;

  Myejemplo({
    Key? key,
    required this.items,
    required this.color,
  }) : super(key: key);

  MyejemploState createState() => MyejemploState();
}

class MyejemploState extends State<Myejemplo> {
  TextEditingController textController = TextEditingController();
  List<Cproducto> filteredItems = [];

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    filteredItems = widget.items;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        toolbarHeight: 90.0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: textController,
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                hintText: "Buscar...",
                contentPadding: EdgeInsets.all(10),
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.60),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(filteredItems[index].nombre),
              onTap: () {
                Navigator.pop(context, filteredItems[index]);
              },
            ),
          );
        },
      ),
    );
  }

  void filterSearchResults(String value) {
    List<Cproducto> searchResults = widget.items
        .where((element) =>
            element.nombre.toLowerCase().contains(value.toLowerCase()) ||
            element.id.toString().contains(value))
        .toList();
    if (searchResults.isNotEmpty) {
      setState(() {
        filteredItems = searchResults;
      });
    } else {
      setState(() {
        filteredItems = widget.items;
      });
    }
  }
}

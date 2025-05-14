import 'dart:convert';

import 'package:cats_app/clases/gato.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Widget principal de la pantalla de inicio
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Estado de la pantalla principal
class _MyHomePageState extends State<MyHomePage> {
  // Aquí se guarda el resultado de la petición a la API de gatos.
  // getGatos() es una función que hace la petición y devuelve una lista de gatos.
  Future<List<Gato>> gatosFuture = getGatos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gatos'),
        actions: [
          // Botón de búsqueda (no tiene funcionalidad aún)
          IconButton(onPressed: null, icon: Icon(Icons.search)),
          // Botón de más opciones (no tiene funcionalidad aún)
          IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // FutureBuilder permite mostrar diferentes widgets según el estado de la petición a la API.
            FutureBuilder(
              future: gatosFuture, 
              builder: (context, snapshot){
                // Mientras se espera la respuesta de la API, muestra un indicador de carga.
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                // Si ocurre un error al pedir los datos, muestra el error.
                } else if(snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                // Si la petición fue exitosa y hay datos, muestra la lista de gatos.
                } else if(snapshot.hasData){
                 final gatos = snapshot.data!;
                 return buildGatos(gatos);
                // Si no hay datos, muestra un mensaje.
                } else {
                  return const Text('No data available');
                }
              }
            )
          ],
        ),
      ),
    );
  }

  // Esta función hace la petición a la API de gatos.
  // Usa http.get para pedir 10 imágenes de gatos.
  // Luego convierte la respuesta (que viene en formato JSON) en una lista de objetos Gato.
  static Future<List<Gato>> getGatos() async {
    var url = Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10');
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = jsonDecode(response.body);
    return body.map((e) => Gato.fromJson(e)).toList();
  }
}

// Esta función recibe una lista de gatos y la muestra en una lista desplazable.
Widget buildGatos(List<Gato> gatos) {
  return Expanded(
    child: ListView.separated(
      itemCount: gatos.length,
      itemBuilder: (BuildContext context,int index) {
        final gato = gatos[index];
        final url = "${gato.url}";

        return ListTile(
          title: Text("${gato.id}"),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(url), // Muestra la imagen del gato desde internet.
          ),
          subtitle: Text("Width: ${gato.width} Height: ${gato.height}"),
          trailing: const Icon(Icons.arrow_forward_ios),
        );
      },
      separatorBuilder: (BuildContext context, int index){
        return const Divider(
          thickness: 2,
        );
      },
    ),
  );
}
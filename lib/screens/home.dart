import 'dart:convert';

import 'package:cats_app/clases/gato.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Gato>> gatosFuture = getGatos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gatos'),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.search)),
          IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: gatosFuture, 
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                } else if(snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                } else if(snapshot.hasData){
                 final gatos = snapshot.data!;
                 return buildGatos(gatos);
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

  static Future<List<Gato>> getGatos() async {
    var url = Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10');
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = jsonDecode(response.body);
    return body.map((e) => Gato.fromJson(e)).toList();
  }
}

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
            backgroundImage: NetworkImage(url),
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
// import 'dart:ffi';
// import 'dart:ffi';
// import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.purple,
      primaryTextTheme: TextTheme(
          subtitle1:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
    ),
    home: HomePage(),
  ));
}

// ------------------------------------------------------------------------//

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://swapi.dev/api/people";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  // ignore: missing_return
  Future<String> getJsonData() async {
    // ignore: unused_local_variable
    var response = await http.get(Uri.http('https://swapi.dev', 'api/people'));
    // var response = await http.get(Uri.https('https://swapi.dev', 'api/people'),
    //     headers: {"accept": "application/json"});
    // print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson["results"];
    });
    return "success";
  }

  final topBar = AppBar(
    leading: Icon(Icons.menu),
    title: Text("HTTP App"),
    centerTitle: true,
    elevation: 11,
    shadowColor: Colors.blueAccent,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar,
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 20,
                      shadowColor: Colors.blue[200],
                      child: Container(
                        color: Colors.redAccent[100],
                        padding: EdgeInsets.all(15),
                        child: Text(data[index]["name"]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

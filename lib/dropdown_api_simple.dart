import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApiDropdown(),
    );
  }
}

class ApiDropdown extends StatefulWidget {
  @override
  _ApiDropdownState createState() => _ApiDropdownState();
}

class _ApiDropdownState extends State<ApiDropdown> {

  String _mySelection;

  final String url = "http://paulodir.site/rest/Raca";

  List data = List();

  Future<String> getRaca() async {
    var res = await http
        .get(Uri.encodeFull(url),
        headers: {'token': 'acesso', "Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getRaca();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Raças Bovinos"),
      ),
      body: new Center(
        child: DropdownButton(
          items: data.map((item) {
//            print('Dentro do Dropdwon');
//            print(data);

            return new DropdownMenuItem(
              child: new Text(item['nome']),
              value: item['id'].toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _mySelection = newVal;
              print(_mySelection);
            });
          },
          value: _mySelection,
        ),
      ),
    );
  }
}

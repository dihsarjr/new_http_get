import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _getHttp();
    super.initState();
  }

  List datas;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Get'),
      ),
      body: datas == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        datas[i]['name'],
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                );
              },
              itemCount: datas.length,
            ),
    );
  }

  Future<void> _getHttp() async {
    final url = 'https://jsonplaceholder.typicode.com/users';
    var response = await http.get(url);

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        datas = data;
      });
      print(response.body);
    }
  }
}

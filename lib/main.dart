import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_nested/model.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UsersDetail> _list = [];
  var loading = false;
  Future<Null> _fetchData() async {
    setState(() {
      loading = true;
    });
    final response =
        await http.get("https://jsonplaceholder.typicode.com/users");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(UsersDetail.fromJson(i));
        }
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, i) {
                  final x = _list[i];
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(x.name),
                        Text(x.email),
                        Text(x.phone),
                        Text(x.website),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(x.address.street),
                        Text(x.address.suite),
                        Text(x.address.city),
                        Text(x.address.zipcode),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Company",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(x.company.name),
                        
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

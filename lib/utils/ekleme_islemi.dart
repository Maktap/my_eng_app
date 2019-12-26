import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_eng_app/database/database_helper.dart';
import 'package:my_eng_app/utils/kelimeler.dart';

import '../main.dart';

class EklemeIslemi extends StatefulWidget {
  EklemeIslemi({Key key}) : super(key: key);

  @override
  _EklemeIslemiState createState() => _EklemeIslemiState();
}

class _EklemeIslemiState extends State<EklemeIslemi> {
  DatabaseHelper _databaseHelper;
  List<String> _list = ['Kelime ', 'Cümle', 'Anlam', 'Cümle Anlam'];
  TextEditingController _controller0, _controller1, _controller2, _controller3;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _controller0 = TextEditingController();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ekleme"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.blue.shade300,
                Colors.purple.shade900
              ])),
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _controller0,
                  decoration: InputDecoration(
                      labelText: _list[0],
                      labelStyle: TextStyle(color: Colors.purple, fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _controller1,
                  decoration: InputDecoration(
                      labelText: _list[1],
                      labelStyle: TextStyle(color: Colors.purple, fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _controller2,
                  decoration: InputDecoration(
                      labelText: _list[2],
                      labelStyle: TextStyle(color: Colors.purple, fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _controller3,
                  decoration: InputDecoration(
                      labelText: _list[3],
                      labelStyle: TextStyle(color: Colors.purple, fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: FlatButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5))),
                  highlightColor: Colors.green,
                  color: Colors.blue,
                  child: Text('Kaydet'),
                  onPressed: () async {
                    await _databaseHelper
                        .kelimeleriINSERT(new Kelimeler(
                            _controller0.text, _controller2.text, 0,
                            cumle: _controller1.text,
                            cumleanlam: _controller3.text))
                        .then((onValue) {
                      print(
                          '${_controller0.text}, ${_controller2.text}, ${0}, ${_controller1.text}, ${_controller3.text} eklendi...');
                      Navigator.of(context).pop(MaterialPageRoute(
                          builder: (BuildContext context) => MyApp()));
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: FlatButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5))),
                  highlightColor: Colors.green,
                  color: Colors.redAccent,
                  child: Text('Vazgeç'),
                  onPressed: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                        builder: (BuildContext context) => MyApp()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_eng_app/database/database_helper.dart';
import 'package:my_eng_app/utils/kelimeler.dart';



class KelimeDuzenle extends StatefulWidget {
  final Kelimeler kelime;
  KelimeDuzenle(this.kelime, {Key key}) : super(key: key);

  @override
  _KelimeDuzenleState createState() => _KelimeDuzenleState();
}

class _KelimeDuzenleState extends State<KelimeDuzenle> {
  String _kelimE, _cumle, _anlam, _cumleAnlam;
  TextEditingController _controllerKelime,
      _controllerCumle,
      _controllerAnlam,
      _controllerCumleAnlam;
  DatabaseHelper databaseHelper;
  int _id, _learned;
  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    _id = widget.kelime.getKelimeID;
    _learned = widget.kelime.getlearned;
    _kelimE = widget.kelime.getKelime;
    _cumle = widget.kelime.getCumle;
    _anlam = widget.kelime.getAnlam;
    _cumleAnlam = widget.kelime.getCumleAnlam;
    _controllerKelime = TextEditingController(text: _kelimE);
    _controllerCumle = TextEditingController(text: _cumle);
    _controllerAnlam = TextEditingController(text: _anlam);
    _controllerCumleAnlam = TextEditingController(text: _cumleAnlam);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kelime Düzenle'),
        ),
        body: Container(
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
                  controller: _controllerKelime,
                  decoration: InputDecoration(
                      labelText: 'Kelime',
                      labelStyle: TextStyle(color: Colors.purple, fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _controllerCumle,
                  decoration: InputDecoration(
                      labelText: 'Cumle',
                      labelStyle: TextStyle(color: Colors.purple, fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _controllerAnlam,
                  decoration: InputDecoration(
                      labelText: 'Anlam',
                      labelStyle: TextStyle(color: Colors.purple, fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _controllerCumleAnlam,
                  decoration: InputDecoration(
                      labelText: 'CumleAnlam',
                      labelStyle: TextStyle(color: Colors.purple, fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    shape: StadiumBorder(),
                    color: Colors.purple,
                    onPressed: () {
                      databaseHelper
                          .kelimeleriUPDATE(new Kelimeler.withID(
                              _id,
                              _controllerKelime.text,
                              _controllerAnlam.text,
                              _learned,
                              cumle: _controllerCumle.text,
                              cumleanlam: _controllerCumleAnlam.text))
                          .then((onValue) {
                        setState(() {
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Kaydet',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Vazgeç',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.75),
                          ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

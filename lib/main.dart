import 'package:flutter/material.dart';
import 'package:my_eng_app/database/database_helper.dart';
import 'package:my_eng_app/utils/ekleme_islemi.dart';
import 'package:my_eng_app/utils/kelime_detay.dart';
import 'package:my_eng_app/utils/kelimeler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  DatabaseHelper _databaseHelper;
  TabController _tabController;
  List<Kelimeler> _tumKelimeler, _tamamlanmis, _tamamlanmamis;
  PageStorageKey _myPSKTamamlanmamis, _myPSKTamamlanmis;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tumKelimeler = List();
    _tamamlanmis = List();
    _tamamlanmamis = List();
    _myPSKTamamlanmamis = PageStorageKey('tamamlanmamis');
    _myPSKTamamlanmis = PageStorageKey('tamamlanmis');
  }

  Future<List> _tumKelimelereiListeyeAta() async {
    _tumKelimeler = [];
    List tumListe = await _databaseHelper.kelimeleriGetir();
    tumListe.forEach((maps) {
      _tumKelimeler.add(Kelimeler.fromMap(maps));
    });
    _tamamlanmis = [];
    _tamamlanmamis = [];
    _tumKelimeler.forEach((kelime) {
      (kelime.getlearned == 1)
          ? _tamamlanmis.add(kelime)
          : _tamamlanmamis.add(kelime);
    });
    return tumListe;
  }

  @override
  void dispose() {
    print(-1);
    print("dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          labelStyle: TextStyle(fontSize: 18),
          onTap: (tabIndex) {
            setState(() {});
          },
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "Kelimeler",
            ),
            Tab(text: "Tamamlanan"),
          ],
        ),
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
          child: buildTabBarView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return EklemeIslemi();
          }));
        },
        tooltip: 'void',
        child: Icon(Icons.add),
      ),
    );
  }

  TabBarView buildTabBarView() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: <Widget>[
        //Eleman -1
        FutureBuilder(
          future: _tumKelimelereiListeyeAta(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return buildGridView(_tamamlanmamis, false);
            } else {
              return Container();
            }
          },
        ),
        //Eleman -2
        buildGridView(_tamamlanmis, true),
      ],
    );
  }

  buildGridView(List<Kelimeler> liste, bool isDone) => GridView.builder(
        key: (isDone) ? _myPSKTamamlanmis : _myPSKTamamlanmamis,
        itemCount: liste.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 21 / 9),
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                return await showDialog(
                    context: context,
                    builder: (context) {
                      String _icerik;
                      (liste[index].getlearned == 0)
                          ? _icerik =
                              'Bu kelimeyi Tamamlanmış kısmına atmak isyor musunuz'
                          : _icerik =
                              'Bu kelimeyi Tamamlanmamış kısmına atmak isyor musunuz';

                      return buildAlertDialog(liste, index, context, _icerik);
                    });
              } else {
                return kelimeSil(liste[index]);
              }
            },
            key: UniqueKey(),
            child: GestureDetector(
              onLongPress: () {
                print('$index');
              },
              onTap: () {
                print(liste[index].getKelimeID);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Detay(liste, index)));
              },
              child: Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(20),
                  elevation: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(15, 15))
                        ],
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [
                              0.1,
                              0.5,
                              1
                            ],
                            colors: <Color>[
                              Color(0xFFEB29B0),
                              Color(0xFF6300BB),
                              Color(0xFF1C00AA),
                            ])),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          liste[index].getKelime,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontSize: 44,
                              shadows: [
                                Shadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: Offset(5, 5))
                              ]),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
            ),
          );
        },
      );

  AlertDialog buildAlertDialog(
      List<Kelimeler> liste, int index, BuildContext context, String content) {
    return AlertDialog(
      title: Text("Uyarı"),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            if (liste[index].getlearned == 0) {
              _databaseHelper.kelimeleriUPDATE(
                Kelimeler.withID(
                  liste[index].getKelimeID,
                  liste[index].getKelime,
                  liste[index].getAnlam,
                  1, //1 -> öğrenildi
                  cumle: liste[index].getCumle,
                  cumleanlam: liste[index].getCumleAnlam,
                ),
              );
            } else if (liste[index].getlearned == 1) {
              _databaseHelper.kelimeleriUPDATE(
                Kelimeler.withID(
                  liste[index].getKelimeID,
                  liste[index].getKelime,
                  liste[index].getAnlam,
                  0, //1 -> öğrenildi
                  cumle: liste[index].getCumle,
                  cumleanlam: liste[index].getCumleAnlam,
                ),
              );
              await _tumKelimelereiListeyeAta();
            }
            setState(() {
              Navigator.pop(context, true);
            });
          },
          child: Text("Evet"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(
            "Hayır",
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }

  kelimeSil(Kelimeler silinecekKelime) {
    setState(()  {
       _databaseHelper.kelimeleriDELETE(silinecekKelime.getKelimeID);
    });
  }
}

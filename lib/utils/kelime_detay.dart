import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_eng_app/utils/kelime_duzenle.dart';
import 'package:my_eng_app/utils/kelimeler.dart';

import 'custom_dialog.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class Detay extends StatefulWidget {
  final List<Kelimeler> _liste;
  final int _index;
  Detay(this._liste, this._index);

  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _frontScale;
  Animation<double> _backScale;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _frontScale = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.mode_edit,
              size: 28,
            ),
            onSelected: (value) {
              switch (value) {
                case 0:
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          KelimeDuzenle(widget._liste[widget._index])));
                  break;
                case 1:         
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title: 'SİL',
                      description: 'Silmek istediğin fikrinde sabit misin ?',
                      buttonTextYes: 'Evet',
                      buttonTextNo: 'Hayır',
                      image: 'assets/images/stunned.jpg',
                    ),
                  ).then((val) => print(val));
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  value: 0,
                  child: Text('Düzenle'),
                ),
                PopupMenuDivider(
                  height: 5,
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('Sil'),
                ),
              ];
            },
          )
        ],
        centerTitle: true,
        title: Text('Kelime Detay'),
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              new AnimatedBuilder(
                //ARKA
                child: buildContainer(widget._liste[widget._index].getAnlam,
                    widget._liste[widget._index].getCumleAnlam),
                animation: _backScale,
                builder: (BuildContext context, Widget child) {
                  final Matrix4 transform = new Matrix4.identity()
                    ..scale(1.0, _backScale.value, 1.0);
                  return new Transform(
                    transform: transform,
                    alignment: FractionalOffset.center,
                    child: child,
                  );
                },
              ),
              new AnimatedBuilder(
                //ÖN
                child: buildContainer(widget._liste[widget._index].getKelime,
                    widget._liste[widget._index].getCumle),
                animation: _frontScale,
                builder: (BuildContext context, Widget child) {
                  final Matrix4 transform = new Matrix4.identity()
                    ..scale(1.0, _frontScale.value, 1.0);
                  return new Transform(
                    transform: transform,
                    alignment: FractionalOffset.center,
                    child: child,
                  );
                },
              ),
              Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.bottomRight,
                child: FlatButton.icon(
                  textColor: Colors.white54,
                  icon: Icon(Icons.arrow_back_ios),
                  label: Text(
                    'Back',
                    style: TextStyle(fontSize: 22),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.blue.shade300,
                Colors.purple.shade900
              ])),
        ),
      ),
    );
  }

  buildContainer(String str1, str2) {
    return Center(
      child: InkWell(
        onTap: () {
          setState(() {
            if (_controller.isCompleted || _controller.velocity > 0)
              _controller.reverse();
            else
              _controller.forward();
          });
        },
        child: Container(
          alignment: FractionalOffset.center,
          height: 200.0,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: new BoxDecoration(
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
                ]),
            borderRadius: BorderRadius.circular(20),
            border: new Border.all(
              color: new Color(0xFF9E9E9E),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                str1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontSize: 44,
                    shadows: [
                      Shadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(5, 5))
                    ]),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                str2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontSize: 24,
                    shadows: [
                      Shadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(5, 5))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

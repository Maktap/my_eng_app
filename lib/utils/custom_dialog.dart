import 'package:flutter/material.dart';


class CustomDialog extends StatelessWidget {
  final String title, description, buttonTextYes, buttonTextNo, image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonTextYes,
    @required this.buttonTextNo,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        //...top circlular image part,
        Container(
          padding: EdgeInsets.only(
            top: 82,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 66),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      buttonTextYes,
                      style: TextStyle(),
                    ),
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context).popUntil((x) => count++ >= 2);                      
                    },
                  ),
                  FlatButton(
                    child: Text(buttonTextNo),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: 86,
          right: 86,
          child: CircleAvatar(
            backgroundImage: AssetImage(image),
            backgroundColor: Colors.blueAccent,
            radius: 66,
          ),
        ),
      ],
    );
  }
}

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:studen_db/utilities/appConstants.dart';
import 'dart:ui';
import 'package:studen_db/utilities/errorController.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  Offset _interactOffset;
  ErrorController animController = new ErrorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: GestureDetector(
                onPanStart: (DragStartDetails details) {
                  animController.play("sad");
                  setState(() {
                    _interactOffset = details.globalPosition;
                    animController.lookAt(_interactOffset);
                  });
                },
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _interactOffset = details.globalPosition;
                    animController.lookAt(_interactOffset);
                  });
                },
                onPanEnd: (DragEndDetails details) {
                  setState(() {
                    _interactOffset = null;
                    animController.lookAt(_interactOffset);
                  });
                },
                child: FlareActor(
                  "assets/error1.flr",
                  controller: animController,
                  animation: "Untitled",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              )),
          Center(
            child: Text('No Students Added'),
          ),
          Container(
            width: 140,
            height: 50,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/studentForm');
              },
              textColor: Colors.white,
              color: AppConstants.primaryCol,
              child: Text(
                "ADD NEW",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}

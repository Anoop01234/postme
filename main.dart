import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
void main() => runApp(MaterialApp(
    home: Home()
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File imageFile;
  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }


  Future<void>_showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Make a choice !'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Text('Gallary'),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    _openCamera(context);
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _decide(){
    if(imageFile==null){
      return Text('No Selected Image!');
    }
    else{
      return Image.file(imageFile,width: 400,height: 400,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Center(child: Text('Post Here')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Enter heading below", style: TextStyle(fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic, fontSize: 17.0), ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(style: TextStyle(fontSize: 20.0,
                fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
            ),
            _decide(),
            RaisedButton(onPressed: (){
              _showChoiceDialog(context);
            }, child: Text('Select Image !',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), ),
              color: Colors.amber[400],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Enter content below", style: TextStyle(fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic, fontSize: 17.0), ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(obscureText: false,style: TextStyle(fontSize: 15.0,), textAlign: TextAlign.left,),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton.icon(onPressed: (){} ,
                icon: Icon(Icons.save), label: Text('Save'), color: Colors.amber[300],),
            )
          ],
        ),
      ),
    );
  }
}


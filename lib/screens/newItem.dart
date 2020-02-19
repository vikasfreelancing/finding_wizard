import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
/*
* Item Service base url https://itemservice.herokuapp.com
* */

class NewItem extends StatefulWidget {
  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  List<File> _images = List<File>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextStyle styleCountGreen = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 30.0,
    color: Colors.green[900],
  );
  TextStyle styleCountRed = TextStyle(
      fontFamily: 'Montserrat', fontSize: 30.0, color: Colors.red[900]);
  List<Widget> get() {
    List<Widget> I = List<Widget>();
    _images.forEach((file) {
      I.add(Expanded(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Image.file(file),
            ),
            Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _images.remove(file);
                    upLoaded--;
                    panding++;
                  });
                },
                child: Icon(
                  Icons.close,
                  color: Colors.red[300],
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ));
    });
    return I;
  }

  Future getImageFromCamera() async {
    if (upLoaded == 6) return;
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _images.add(image);
      upLoaded++;
      panding--;
    });
  }

  Future getImageFromGallery() async {
    if (upLoaded == 6) return;
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _images.add(image);
      upLoaded++;
      panding--;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  int upLoaded = 0;
  int panding = 6;
  @override
  Widget build(BuildContext context) {
    final uploadButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Upload",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Color(0xff685EF2), fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Lost Item'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: _images.isEmpty
                  ? Text(
                      "Please Select 6 Images of lost Item",
                      style: style,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "$upLoaded ",
                          style: styleCountGreen,
                        ),
                        Text(
                          "Uploaded ",
                          style: style,
                        ),
                        Text(
                          "$panding",
                          style: styleCountRed,
                        ),
                        Text(
                          "Pending",
                          style: style,
                        )
                      ],
                    ),
            ),
          ),
          Expanded(
            flex: 8,
            child: _images.isEmpty
                ? Center(
                    child: Text(
                      "No Image selected",
                      style: styleCountRed,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: get(),
                    ),
                  ),
          ),
          Expanded(
            flex: 5,
            child: Center(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: getImageFromGallery,
                    child: Icon(
                      Icons.add_photo_alternate,
                      size: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: uploadButton,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: getImageFromCamera,
                    child: Icon(
                      Icons.camera,
                      size: 50,
                    ),
                  ),
                ),
              ],
            )),
          )
        ],
      )),
    );
  }
}

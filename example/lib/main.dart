import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _fileName = '...';
  String _path = '...';
  FileType _pickingType;

  void _openFileExplorer() async {
    try {
      _path = await FilePicker.getFilePath(type: _pickingType);
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) return;

    setState(() {
      _fileName = _path != null ? _path.split('/').last : '...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(20.0),
              child: new DropdownButton(
                hint: new Text('LOAD FILE PATH FROM...'),
                value: _pickingType,
                items: <DropdownMenuItem>[
                  new DropdownMenuItem(
                    child: new Text('FROM CAMERA'),
                    value: FileType.CAPTURE,
                  ),
                  new DropdownMenuItem(
                    child: new Text('FROM GALLERY'),
                    value: FileType.IMAGE,
                  ),
                  new DropdownMenuItem(
                    child: new Text('FROM PDF'),
                    value: FileType.PDF,
                  ),
                  new DropdownMenuItem(
                    child: new Text('FROM VIDEO'),
                    value: FileType.VIDEO,
                  ),
                  new DropdownMenuItem(
                    child: new Text('FROM ANY'),
                    value: FileType.ANY,
                  )
                ],
                onChanged: (value) {
                  setState(
                    () {
                      _pickingType = value;
                    },
                  );
                },
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(20.0),
              child: new RaisedButton(
                onPressed: () => _openFileExplorer(),
                child: new Text("Open file picker"),
              ),
            ),
            new Text(
              'URI PATH ',
              textAlign: TextAlign.center,
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            new Text(
              _path ?? '...',
              textAlign: TextAlign.center,
              softWrap: true,
              textScaleFactor: 0.85,
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: new Text(
                'FILE NAME ',
                textAlign: TextAlign.center,
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            new Text(
              _fileName,
              textAlign: TextAlign.center,
            ),
          ],
        )),
      ),
    );
  }
}

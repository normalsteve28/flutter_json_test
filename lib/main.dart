import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'class.dart';

void main() {
  runApp(new MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  State createState() => new HomeState();
}

class HomeState extends State<Home> {
  TextEditingController sysInputController = new TextEditingController();
  TextEditingController diaInputController = new TextEditingController();
  TextEditingController hrInputController = new TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  @override
  void initState() {
    super.initState();
    getExternalStorageDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }

  @override
  void dispose() {
    sysInputController.dispose();
    diaInputController.dispose();
    hrInputController.dispose();
    super.dispose();
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    print(dir);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String syss, String diaa, String hrr) {
    print("Writing to file!");
    Map<String, String> content = {'sys': syss, 'dia': diaa, 'hr': hrr};

    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    print(fileContent);
  }

  void deleteFile() {
    jsonFile.delete();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("JSON Tutorial"),
      ),
      body: new Column(
        children: <Widget>[
          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text(
            "File content: ",
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
          new Text(fileContent.toString()),
          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("Add to JSON file: "),
          new TextField(
            controller: sysInputController,
          ),
          new TextField(
            controller: diaInputController,
          ),
          new TextField(
            controller: hrInputController,
          ),
          new Padding(padding: new EdgeInsets.only(top: 20.0)),
          new RaisedButton(
            child: new Text("Add key, value pair"),
            onPressed: () => writeToFile(sysInputController.text,
                diaInputController.text, hrInputController.text),
          ),
          new RaisedButton(
            child: new Text("Delete file"),
            onPressed: () => deleteFile(),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

import 'dart:typed_data';

//import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body : MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String showFileName = "";
  Color defaultColor = Colors.grey[400]!;

  TextEditingController textController = TextEditingController();

  String message = '';

  double valA = 0;
  double valB = 0;
  double valC = 0;
  double valD = 0;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(valA.toString()),
          Slider(
            value: valA,
            onChanged: (double value) {
              setState(() {
                valA = value;
              });
            },
          ),
          Text(valB.toString()),
          Slider(
            value: valB,
            onChanged: (double value) {
              setState(() {
                valB = value;
              });
            },
          ),
          Text(valC.toString()),
          Slider(
            value: valC,
            onChanged: (double value) {
              setState(() {
                valC = value;
              });
            },
          ),
          Text(valD.toString()),
          Slider(
            value: valD,
            onChanged: (double value) {
              setState(() {
                valD = value;
              });
            },
          ),
          SizedBox(width: 500,
              child: TextField(
                controller: textController,
              )
          ),
          TextButton(
            onPressed: () async {
              String? result = await FilePicker.platform.saveFile(
                type: FileType.custom,
                allowedExtensions: ['nodeai'],
              );
              String path = "";

              if(result != null) {
                if(result!.contains(".nodeai")){
                  path = result!;
                }
                else {
                  path = "${result!}.nodeai";
                }
                print(path);

                Map<String,dynamic> jsonData = {
                  "valA" : valA,
                  "valB" : valB,
                  "valC" : valC,
                  "valD" : valD,
                  "str" : textController.text
                };

                String encodedData = jsonEncode(jsonData);

                File writeFile = File(path);
                writeFile.writeAsString(encodedData);
              }
            },
            child: const Text(
                "Save file"
            ),
          ),
          TextButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['nodeai'],
              );

              if(result != null && result.files.isNotEmpty){
                String fileName = result.files.first.name;

                print(result.files.first.path?? "");

                if(result.files.first.path != null) {
                  File readFile = File(result.files.first.path!);
                  message = await readFile.readAsString();

                  Map<String,dynamic> jsonData = jsonDecode(message);

                  setState(() {
                    showFileName = "Now File Name: $fileName";
                    message = jsonData['str'];
                    valA = jsonData['valA'];
                    valB = jsonData['valB'];
                    valC = jsonData['valC'];
                    valD = jsonData['valD'];
                  });
                }
              }
            },
            child: const Text(
                "Read file"
            ),
          ),
          Text(showFileName),
          Text(message)
        ],
      ),
    );
  }
}
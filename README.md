# file_test

using ```file_picker: ^4.5.0```

### save file
return data is path of selected
```dart
// get file path
String? result = await FilePicker.platform.saveFile(
                type: FileType.custom,
                allowedExtensions: ['nodeai'],
              );


//write file
File writeFile = File(path);
writeFile.writeAsString(encodedData);
```

### read files
```dart
// getting result
// can enable multiple files with "allowMultiple = true"
FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['nodeai'],
              );


//get file name and read file as string
if(result != null && result.files.isNotEmpty){
  String fileName = result.files.first.name;
  
  if(result.files.first.path != null) {
      File readFile = File(result.files.first.path!);
      message = await readFile.readAsString();
  }
}
```

### get Directory path
can select directory
return as path string
```dart
String? result = await FilePicker.platform.getDirectoryPath();

if(result != null) {
  print(Directory(result).listsync());
}
```


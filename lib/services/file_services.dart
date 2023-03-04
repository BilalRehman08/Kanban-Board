import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileServices {
  static Future<File> exportCSV({required String csv, required String fileName}) async {
    final directory = await getExternalStorageDirectory();
    final Directory appDocDirFolder =
        Directory('${directory!.path}/KanbanBoard');
    final Directory appDocDirNewFolder =
        await appDocDirFolder.create(recursive: true);
    final path = appDocDirNewFolder.path;
    final file = File('$path/$fileName.csv');
    await file.writeAsString(csv); 
    return file;  
  }

}
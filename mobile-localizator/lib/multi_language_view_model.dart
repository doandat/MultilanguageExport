import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:multilang/model/Column.dart';
import 'package:multilang/model/language.dart';
import 'package:path_provider/path_provider.dart';

class MultiLanguageViewModel extends ChangeNotifier {
  var name = "Hello";
  var rawData = "";

  bool loading = true;

  var client = http.Client();
  List<Column> columns = List<Column>.empty();
  List<Language> languages = List<Language>.empty();

  void initData(String key) async {
    loading = true;
    columns = List<Column>.empty();
    languages = List<Language>.empty();
    notifyListeners();
    // await Future.delayed(const Duration(seconds: 5));
    name = "Hello World";

    var uri = Uri.https("spreadsheets.google.com", "tq",
        {"key": key});

    var res = await client.get(uri);

    var sIndex = "google.visualization.Query.setResponse(";
    var startIndex = res.body.indexOf(sIndex) + sIndex.length;
    var endIndex = res.body.length - 2;
    rawData = res.body.substring(startIndex, endIndex);

    await processData(rawData);

    print("update name ==============");

    loading = false;
    notifyListeners();
  }

  Future processData(String text) async {
    Map<String, dynamic> data = jsonDecode(text);

    List<dynamic> cols = data["table"]["cols"];
    List<dynamic> rows = data["table"]["rows"];

    columns =
        List.generate(cols.length, (index) => Column.fromJson(cols[index]));

    languages = List.generate(rows.length, (index) {
      List<dynamic> cs = rows[index]["c"];
      String? no = null;
      try {
        no = (cs[0] != null) ? (cs[0]["v"] as double).toInt().toString() : null;
      } catch (e) {
        no = (cs[0] != null) ? cs[0]["v"].toString() : null;
      }

      String? module = (cs[1] != null) ? cs[1]["v"] : null;
      String? key = (cs[2] != null) ? cs[2]["v"] : null;
      bool format = (cs[3] != null) ? cs[3]["v"] : false;
      bool android = (cs[4] != null) ? cs[4]["v"] : false;
      bool ios = (cs[5] != null) ? cs[5]["v"] : false;
      String? vietnamese = (cs.length > 6 && cs[6] != null) ? cs[6]["v"] : null;
      String? english = (cs.length > 7 && cs[7] != null) ? cs[7]["v"] : null;
      String? chinese = (cs.length > 8 && cs[8] != null) ? cs[8]["v"] : null;
      String? korean = (cs.length > 9 && cs[9] != null) ? cs[9]["v"] : null;
      String? japanese = (cs.length > 10 && cs[10] != null) ? cs[10]["v"] : null;
      String? german = (cs.length > 11 && cs[11] != null) ? cs[11]["v"] : null;
      String? french = (cs.length > 12 && cs[12] != null) ? cs[12]["v"] : null;

      return Language(
        no,
        module,
        key,
        format,
        android,
        ios,
        vietnamese?.trim() ?? "",
        english?.trim() ?? "",
        chinese?.trim() ?? "",
        korean?.trim() ?? "",
        japanese?.trim() ?? "",
        german?.trim() ?? "",
        french?.trim() ?? "",
      );
    });
  }

  Future<String> exportForAndroid(String code) async {
    Directory tempDir = await getTemporaryDirectory();
    // Directory tempDir = await getApplicationDocumentsDirectory();

    String fileName = "strings-$code.xml";
    String filePath = "${tempDir.path}/$fileName";

    File file = File(filePath);

    StringBuffer buffer = StringBuffer();
    buffer.writeln('''<?xml version="1.0" encoding="utf-8"?>''');
    buffer.writeln('''<resources>''');

    for (var lang in languages) {
      if (lang.key == null || lang.key?.isEmpty == true || !lang.android)
        continue;
      String value = lang.getValue(code);
      if (value == null || value.isEmpty) {
        value = "[$code]${lang.getValue(Language.languageVietnamese)}";
      }

      buffer.write("    ");
      if (lang.format) {
        buffer.writeln(
            '''<string name="${lang.key}"><![CDATA[$value ]]></string>''');
      } else {
        buffer.writeln(
            '''<string name="${lang.key}">${value.replaceAll(" & ", " &amp; ")
                .replaceAll(" &\\n", " &amp;\\n")
                .replaceAll("<", "&lt;")}</string>''');
      }
    }

    buffer.writeln('''</resources>''');

    await file.writeAsString(buffer.toString());

    int length = await file.length();
    print("========== length ========== ${length}");

    return filePath;
  }

  Future<String> exportForIOS(String code) async {
    Directory tempDir = await getTemporaryDirectory();
    // Directory tempDir = await getApplicationDocumentsDirectory();

    String fileName = "localize_$code.txt";
    String filePath = "${tempDir.path}/$fileName";

    File file = File(filePath);

    StringBuffer buffer = StringBuffer();

    buffer.writeln(''' ''');
    for (var lang in languages) {
      if (lang.key == null || lang.key?.isEmpty == true || !lang.iOS) continue;

      String value = lang
          .getValue(code)
          .replaceAll("%d", "%@")
          .replaceAll("%s", "%@")
          .replaceAll("%f", "%@");

      if (value == null || value.isEmpty) {
        value =
            "[$code]${lang.getValue(Language.languageVietnamese).replaceAll("%d", "%@").replaceAll("%s", "%@").replaceAll("%f", "%@")}";
      }

      // buffer.write("");
      if (lang.format) {
        buffer.writeln('''"${lang.key}" = "${value.replaceAll("\"", "\\\"")}";''');
      } else {
        buffer.writeln('''"${lang.key}" = "$value";''');
      }
    }

    buffer.writeln(''' ''');

    await file.writeAsString(buffer.toString());

    int length = await file.length();
    print("========== length ========== ${length}");

    return filePath;
  }
}

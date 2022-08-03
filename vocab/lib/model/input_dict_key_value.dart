import 'dart:io';

import 'input_dict.dart';

class InputDictKeyValue extends InputDict {
  Map<String, List<String>> dict = <String, List<String>>{};
  InputDictKeyValue(super.filePath);
  @override
  Future load() async {
    var lines = await File(filePath).readAsLines();
    for (var l in lines) {
      var keyValues = l.split('-');
      var term = keyValues[0].trim();
      terms.add(term);
      dict[term] = keyValues[1]
          .split(',')
          .map((e) => e.trim())
          .where((element) => element.isNotEmpty)
          .toList();
    }
  }
}

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:vocab/dict/word_entity.dart';

List<String> priorities = [
  "Principal Translations",
  "Additional Translations",
  "Compound Forms"
];

WordEntity processHtml(String html) {
  var document = parse(html);
  var de = document.body!.querySelector('h3.headerWord')!.text;

  var meanings = <Meaning>[];

  var tables = document.body!.querySelectorAll('table.WRD');
  if (tables.isNotEmpty) {
    for (var p in priorities) {
      var priorityTable = tables
          .where((element) => element.querySelector('td[title="$p"]') != null);
      if (priorityTable.isNotEmpty) {
        meanings.addAll(processTable(priorityTable.first));
        break;
      }
    }
  }

  return WordEntity(de, meanings);
}

List<Meaning> processTable(Element tableElement) {
  var result = <Meaning>[];
  var wrds = [];

  Element? line = tableElement.querySelector('tr');
  do {
    if (line!.attributes['class'] == 'even' ||
        line.attributes['class'] == 'odd') {
      var deWrd = line.querySelector('td.FrWrd')?.querySelector('strong')?.text;
      var mark = line.querySelector('td.FrWrd')?.querySelector('em')?.text;
      var enTag = line.querySelector('td.ToWrd');
      String? en = null;
      if (enTag?.nodes != null) {
        var textNodes = enTag!.nodes.where((element) => element.nodeType == 3);
        if (textNodes.isNotEmpty) {
          en = textNodes.first.text!.trim();
        }
      }
      if (deWrd != null && mark != null && en != null) {
        result.add(Meaning(
          deWrd.replaceAll('  ', ''),
          [en],
          mark,
        ));
      } else if (en != null) {
        result.last.engs.add(en);
      }
    }
    line = line.nextElementSibling;
  } while (line != null);

  return result;
}

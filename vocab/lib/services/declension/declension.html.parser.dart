import 'package:html/parser.dart';
import 'package:vocab/model/declension/declension_dict.dart';
import 'package:vocab/model/declension/declension_set.dart';

class DeclensionHtmlParser {
  DeclensionSet? processHtml(String html) {
    var document = parse(html);
    var baseForm = document.querySelector('#grundform')!.text.trim();
    print(baseForm);

    var stemForms = document
        .querySelector('#stammformen')!
        .text
        .split('·')
        .map((e) => e.trim());

    var presentThirdSingular = stemForms.first;
    var pastThirdSingular = stemForms.elementAt(1);
    var past = stemForms.last;

    var tbl = document
        .querySelector('.rBox.rBoxWht')!
        .nextElementSibling!
        .nextElementSibling!
        .nextElementSibling!
        .nextElementSibling!
        .querySelector('.rAufZu');
    var forms = tbl!.querySelectorAll('.vTbl table');
    var l = <List<String>>[];
    for (var f in forms) {
      l.add(f.text
          .replaceAll('ich', '')
          .replaceAll('du', '')
          .replaceAll('er', '')
          .replaceAll('wir', '')
          .replaceAll('ihr', '')
          .replaceAll('sie', '')
          .replaceAll('\n', ',')
          .split(' ')
          .map((e) => e.trim())
          .where((element) => element.length > 0)
          .toList());
    }
    
    return DeclensionSet(
      baseForm, presentThirdSingular, pastThirdSingular, past, 
      l[0], translation, imperative, imperfect, presentSubj, imperfSubj, infinitiv, participle)
  }
}

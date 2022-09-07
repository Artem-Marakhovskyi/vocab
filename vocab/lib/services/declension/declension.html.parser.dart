import 'package:html/parser.dart';
import 'package:vocab/model/declension/declension_set.dart';

class DeclensionHtmlParser {
  DeclensionSet? processHtml(String html) {
    print(html);
    var document = parse(html);
    var baseForm = document.querySelector('#grundform');

    if (baseForm == null) return null;

    var baseFormValue = baseForm.text.trim();

    var stemFormsSelector = document.querySelector('#stammformen');

    if (stemFormsSelector == null) return null;

    var stemForms = stemFormsSelector.text.split('·').map((e) => e.trim());

    if (stemForms.isEmpty) return null;

    var presentThirdSingular = stemForms.first;
    var pastThirdSingular = stemForms.elementAt(1);
    var past = stemForms.last;

    var translationSelector = document.querySelector('.r1Zeile.rU3px.rO0px');

    var tblsSelector = document.querySelector('.rBox.rBoxWht');

    if (tblsSelector == null) {
      return DeclensionSet(
        baseFormValue,
        presentThirdSingular,
        pastThirdSingular,
        past,
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
      );
    }

    var translations = <String>[];

    if (translationSelector == null) {
      return DeclensionSet(
        baseFormValue,
        presentThirdSingular,
        pastThirdSingular,
        past,
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
      );
    }

    translations = translationSelector.text
        .replaceAll('\n', ',')
        .split(',| ')
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty && element != ',')
        .toList();

    var tbl = tblsSelector.nextElementSibling!.nextElementSibling!
        .nextElementSibling!.nextElementSibling!
        .querySelector('.rAufZu');

    if (tbl == null) {
      return DeclensionSet(
        baseFormValue,
        presentThirdSingular,
        pastThirdSingular,
        past,
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
        <String>[],
      );
    }

    var formsSelector = tbl.querySelectorAll('.vTbl table');

    if (formsSelector == null) return null;

    var forms = formsSelector;
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
          .where((element) => element.isNotEmpty)
          .toList());
    }

    return DeclensionSet(
        baseFormValue,
        presentThirdSingular,
        pastThirdSingular,
        past,
        l.isNotEmpty ? l[0] : <String>[],
        translations,
        l.length > 2 ? l[2] : <String>[],
        l.length > 1 ? l[1] : <String>[],
        l.length > 2 ? l[3] : <String>[],
        l.length > 4 ? l[4] : <String>[],
        l.length > 6 ? l[6] : <String>[],
        l.length > 5 ? l[5] : <String>[]);
  }
}

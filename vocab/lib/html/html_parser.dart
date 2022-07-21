import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:vocab/dict/verb_entity.dart';

WordEntity processHtml(String html) {
  var document = parse(html);
  var de = document.body!.querySelector('h3.headerWord');
  var en = document.body!.querySelector('#pronWR')!.text;
  //   .text(), en, partOfSpeech, synonyms);
  // result.en =
  // result.pronWR = $('span#pronWR').text()
  // result.audio = $('div#listen_widget audio source')
  //   .map(function (i, el) { return $(this).attr('src') })
  //   .get()
  // var tables = $('table.WRD')
  //   .map(function (i, el) { return $(this).html() })
  //   .get()
  // result.translations = tables.map(WRDtableMap)

  // return result

  return WordEntity(de!.text, en, 'partOfSpeech', ['synonyms']);
}

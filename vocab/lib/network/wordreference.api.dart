import 'package:http/http.dart' as http;

class WordReferenceApi {
  final String _baseUrl = 'http://www.wordreference.com/{src}{dest}/{word}';

  Future<String> getHtml(String srcLang, String destLang, String term) async {
    var langReadyUrl = _baseUrl
        .replaceAll("{src}", srcLang)
        .replaceAll('{word}', term)
        .replaceAll('{dest}', destLang)
        .replaceAll('ü', '%C3%BC')
        .replaceAll('ä', '%C3%A4')
        .replaceAll('ö', '%C3%B6');

    var response = await http.get(Uri.parse(langReadyUrl));

    return response.body;
  }
}

import 'package:http/http.dart' as http;

class WordReferenceApi {
  final String _baseUrl = 'http://www.wordreference.com/{src}{dest}/{word}';

  Future<String> getHtml(String srcLang, String destLang, String term) async {
    var langReadyUrl =
        _baseUrl.replaceAll("{src}", srcLang).replaceAll('{dest}', destLang);
    var uri = Uri.parse(langReadyUrl.replaceAll('{word}', term));
    var response = await http.get(uri);

    return response.body;
  }
}

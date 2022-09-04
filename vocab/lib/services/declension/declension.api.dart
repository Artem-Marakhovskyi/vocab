import 'package:http/http.dart' as http;

class DeclensionApi {
  final String _baseUrl = 'https://www.verbformen.com/declension/?w={word}';

  Future<String> getHtml(String term) async {
    var langReadyUrl = _baseUrl.replaceAll('{word}', term);
    var uri = Uri.parse(langReadyUrl);
    var response = await http.get(uri, headers: <String, String>{
      "accept":
          "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
    });

    return response.body;
  }
}

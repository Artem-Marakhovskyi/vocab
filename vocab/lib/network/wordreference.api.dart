import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class WordReferenceApi {
  final String _baseUrl = 'https://www.wordreference.com/{src}{dest}/{word}';

  Future<String> getHtml(String srcLang, String destLang, String term) async {
    var langReadyUrl = _baseUrl
        .replaceAll("{src}", srcLang)
        .replaceAll('{word}', term)
        .replaceAll('{dest}', destLang);
    var uri = Uri.parse(langReadyUrl);
    var response = await http.get(uri, headers: <String, String>{
      "accept":
          "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
    });

    return response.body;
  }
}

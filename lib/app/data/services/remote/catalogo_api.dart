import 'dart:convert';

import '../../http/http.dart';

class CatalogoApi {
  CatalogoApi(this._http);
  final Http _http;

  getCatalogo() async {
    final response = await _http.request(
      'catalogo_controller',
      queryParameters: {'language': 'S', 'lang': 'ES'},
      onSuccess: (responseBody) {
        final json = Map<String, dynamic>.from(
          jsonDecode(responseBody),
        );
        final responseData = json['response']['data']['data'];
        return responseData;
      },
    );
    return response.when(
      (_) => null,
      (catalogo) => catalogo,
    );
  }
}

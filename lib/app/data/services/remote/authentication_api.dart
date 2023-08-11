import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../http/http.dart';
import '../local/generic_service.dart';

class AuthenticationApi {
  //AuthenticationApi(this._client);
  AuthenticationApi(this._http);
  final Http _http;
  final GenericService _genericService = GenericService();
  Either<SignInFailure, String> _handleFailure(HttpFailure failure) {
    if (failure.statusCode != null) {
      switch (failure.statusCode!) {
        case 401:
          return Either.left(SignInFailure.unauthorized);
        case 404:
          return Either.left(SignInFailure.notFound);
        default:
          return Either.left(SignInFailure.unknown);
      }
    }
    if (failure.exception is NetworkException) {
      return Either.left(SignInFailure.network);
    }
    return Either.left(SignInFailure.unknown);
  }
  /* final _baseUrl =
      'https://desarrollo.twiinshrmprueba.com/talento_api/index.php';*/

  Future<Either<SignInFailure, String>> createToken() async {
    final result =
        await _http.request('login_controller?', onSuccess: (responseBody) {
      final json = Map<String, dynamic>.from(
        jsonDecode(responseBody),
      );
      return json['response']['data'][0]['token'];
    });
    return result.when(
      _handleFailure,
      (requestToken) => Either.right(requestToken),
    );
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
  }) async {
    /* varJsonLogi.usuarioUser = this.genericService.encodeString(this.genericService.cleanString(this.varFormLogi.usuarioUser), 123);
    varJsonLogi.usuarioPassword = this.genericService.encodeString(this.genericService.cleanString(this.varFormLogi.usuarioPassword), 123); */
    /*final encodedUsername = _genericService.encodeString(username, 123);*/
    final encodedUsername = _genericService.encodeString(
      _genericService.cleanString(username),
      123,
    );
    /*final cleanedPassword = _genericService.cleanString(password, 123);*/
    final cleanedPassword = _genericService.encodeString(
      _genericService.cleanString(password),
      123,
    );
    final result = await _http.request(
      'login_controller',
      method: HttpMethod.post,
      body: {
        'usuarioUser': encodedUsername,
        'usuarioPassword': cleanedPassword,
        "usuarioToken": "",
        "datosUsuario": "S",
        "datosSistemas": "S",
        "validaTwiins": "N",
        "codigoEmpresa": "",
        "datosEmpresas": "S"
      },
      onSuccess: (responseBody) {
        final json = Map<String, dynamic>.from(
          jsonDecode(responseBody),
        );
        final responseData = json['response']['data']['data'][0];
        return responseData['token'] as String;
      },
    );
    return result.when(
      _handleFailure,
      (newRequestToken) => Either.right(
        newRequestToken,
      ),
    );
  }

  Future<Either<SignInFailure, String>> createSession(
    String token,
  ) async {
    final result = await _http.request(
      'login_controller?token=$token',
      onSuccess: (responseBody) {
        final json = Map<String, dynamic>.from(
          jsonDecode(responseBody),
        );
        final responseData = json['response']['data']['data'][0];
        final usuaCodigo = responseData['usua_codigo'] as String;
        return usuaCodigo;
      },
    );

    return result.when(
      _handleFailure,
      (usuarioCodigo) => Either.right(
        usuarioCodigo,
      ),
    );
    /* try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/login_controller?token=$token'),
      );
      if (response.statusCode == 200) {
        final Json = Map<String, dynamic>.from(
          jsonDecode(response.body),
        );
        final responseData = Json['response']['data'][0];
        final usuaCodigo = responseData['usua_codigo'] as String;
        return Either.right(usuaCodigo);
      }
      return Either.left(SignInFailure.unknown);
    } catch (e) {
      if (e is SocketException) {
        return Either.left(SignInFailure.network);
      }
      return Either.left(SignInFailure.unknown);
    } */
  }
}

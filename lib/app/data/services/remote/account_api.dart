import 'dart:convert';

import '../../../domain/models/user.dart';
import '../../http/http.dart';

class AccountApi {
  AccountApi(this._http);
  final Http _http;

  Future<User?> getAccount(
    String token,
    String usuarioUser,
  ) async {
    String authorization = '$token,$usuarioUser';
    final result = await _http.request(
      'usuario_controller',
      headers: {
        'Authorization': authorization,
      },
      queryParameters: {
        'usuarioUser': usuarioUser,
        'datosGenerales': 'S',
        'datosEvaluaciones': 'N',
        'datosUbicacionOrganizacional': 'S',
        'datosEstructuraFamiliar': 'S',
        'camposEvaluaciones': '{"datosGenerales":"S"}',
        'datosActualizar': 'S',
        'datosPersonales': 'S',
        'datosDomicilio': 'S',
        'datosContactoEmergencia': 'S',
        'datosEstadoEmpleado': 'S',
        'datosFlextime': 'S',
        'datosUbicacionFisica': 'S',
        'datosAdicionales': 'S',
        'datosCondicionesMedicas': 'S',
        'datosMedicos': 'S',
        'datosPerfilUsuario': 'S',
        'datosNomina': 'S',
      },
      onSuccess: (responseBody) {
        final json = Map<String, dynamic>.from(
          jsonDecode(responseBody),
        );
        final responseData = json['response']['data']['data'][0];
        return User(
            username: responseData['usuarioUser'],
            usuarioFoto: responseData['usuarioFoto']);
      },
    );
    return result.when(
      (_) => null,
      (user) => user,
    );
  }
}

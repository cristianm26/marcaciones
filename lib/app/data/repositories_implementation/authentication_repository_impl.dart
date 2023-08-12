import '../../domain/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';
import '../services/remote/authentication_api.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  /* final FlutterSecureStorage _secureStorage; */
  final AuthenticationApi _authenticationApi;
  final SessionService _sessionService;
  final AccountApi _accountApi;
  AuthenticationRepositoryImpl(
    /*  this._secureStorage, */
    this._authenticationApi,
    this._sessionService,
    this._accountApi,
  );

  @override
  Future<bool> get isSignedIn async {
    /*  final sessionId = await _secureStorage.read(key: _key); */
    final sessionId = await _sessionService.sessionId;
    return sessionId != null;
  }

  /* @override
  Future<bool> get isUrlApi async {
    final urlApi = await _sessionService.urlApi;
    return urlApi != null;
  } */

  @override
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
    String domain,
  ) async {
    final loginResult = await _authenticationApi.createSessionWithLogin(
      username: username,
      password: password,
      domain: domain,
    );
    return loginResult.when(
      (failure) async => Either.left(failure),
      (newRequestToken) async {
        await _sessionService.saveToken(newRequestToken);
        //await _sessionService.saveUrlApi(domain);
        //await _sessionService.saveUrlApi(urlApi)
        final sessionResult = await _authenticationApi.createSession(
          newRequestToken,
        );
        return sessionResult.when(
          (failure) async {
            return Either.left(failure);
          },
          (sessionId) async {
            await _sessionService.saveSessionId(sessionId);
            final user =
                await _accountApi.getAccount(newRequestToken, sessionId);
            if (user == null) {
              return Either.left(SignInFailure.unknown);
            }
            return Either.right(
              user,
            );
          },
        );
      },
    );
  }

  @override
  Future<void> signOut() {
    return _sessionService.signOut();
    /* return _secureStorage.delete(key: _key); */
  }
}

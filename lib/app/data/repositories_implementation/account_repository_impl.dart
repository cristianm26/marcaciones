import '../../domain/models/user.dart';
import '../../domain/repositories/account.repository.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(
    this._accountApi,
    this._sessionService,
  );
  final AccountApi _accountApi;
  final SessionService _sessionService;

  @override
  Future<User?> getUserData() async {
    return _accountApi.getAccount(
      await _sessionService.token ?? '',
      await _sessionService.sessionId ?? '',
    );

    /*  return Future.value(User()); */
  }
}

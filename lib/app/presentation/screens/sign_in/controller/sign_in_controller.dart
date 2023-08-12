import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../global/state_notifier.dart';
import 'sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController(
    super.state, {
    required this.authenticationRepository,
  });
  final AuthenticationRepository authenticationRepository;

  void onUsernameChanged(String text) {
    onlyUpdate(
      state.copyWith(
        username: text.trim().toLowerCase(),
      ),
    );

    /*  update(
      
      notify: false,
    ); */

    // _username = text.trim().toLowerCase();
    /*  String validatedUsername = text.trim().toLowerCase();
    _username = _genericService.cleanString(validatedUsername, 123); */
  }

  void onPasswordChanged(String text) {
    onlyUpdate(
      state.copyWith(
        password: text.replaceAll(' ', ''),
      ),
    );
    /*  _state = _state.copyWith(
      password: text.replaceAll(' ', ''),
    ); */
    //_password = text.replaceAll(' ', '');
    /*  String validatedPassword = text.replaceAll(' ', '');
    _password = _genericService.cleanString(validatedPassword, 123); */
  }

  void onDomainChanged(String text) {
    onlyUpdate(
      state.copyWith(
        domain: text.trim().toLowerCase(),
      ),
    );
    /*  _state = _state.copyWith(
      domain: text.trim().toLowerCase(),
    ); */
    //_domain = text.trim().toLowerCase();
    /*  String validatedDomain = text.trim().toLowerCase();
    _domain = _genericService.cleanString(validatedDomain, 123); */
  }

  // void onFetchingChanged(bool value) {
  /* update(
     
    ); */
  /*  _state = _state.copyWith(
      fetching: value,
    ); */
  //_fetching = value;
  //notifyListeners();
  //}
  Future<Either<SignInFailure, User>> submit() async {
    state.copyWith(
      fetching: true,
    );
    final result = await authenticationRepository.signIn(
      state.username,
      state.password,
      state.domain,
    );
    result.when(
      (_) => state.copyWith(
        fetching: false,
      ),
      (_) => null,
    );
    return result;
  }

  /*  final result = await context.read<AuthenticationRepository>().signIn(
          controller.state.username,
          controller.state.password,
        ); */
}

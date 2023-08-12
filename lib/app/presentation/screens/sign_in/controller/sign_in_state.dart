class SignInState {
  SignInState({
    this.username = '',
    this.password = '',
    this.domain = '',
    this.fetching = false,
  });
  final String username;
  final String password;
  final String domain;
  final bool fetching;
  SignInState copyWith({
    String? username,
    String? password,
    String? domain,
    bool? fetching,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      domain: domain ?? this.domain,
      fetching: fetching ?? this.fetching,
    );
  }
}

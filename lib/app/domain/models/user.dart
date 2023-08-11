import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.username,
    required this.usuarioFoto,
  });
  final String username;
  final String? usuarioFoto;
  @override
  List<Object?> get props => [
        username,
        usuarioFoto,
      ];
}

part of 'auth_cubit.dart';

enum AuthStatus { unauthenticated, loading, authenticated, failure }

extension AuthStatusX on AuthStatus {
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isLoading => this == AuthStatus.loading;
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isFailure => this == AuthStatus.failure;
}

@JsonSerializable()
final class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unauthenticated,
  });

  final AuthStatus status;

  AuthState copyWith({
    AuthStatus? status,
  }) {
    return AuthState(status: status ?? this.status);
  }

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);
  // ignore: lines_longer_than_80_chars, sort_constructors_first
  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);

  @override
  List<Object?> get props => [status];
}

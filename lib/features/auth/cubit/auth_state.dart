part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, success, failure }

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isLoading => this == AuthStatus.loading;
  bool get isSuccess => this == AuthStatus.success;
  bool get isFailure => this == AuthStatus.failure;
}

@JsonSerializable()
final class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
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

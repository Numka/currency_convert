import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.g.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void login(String username, String password) {
    if (username == 'demo' && password == 'demo') {
      emit(state.copyWith(status: AuthStatus.authenticated));
    } else {
      emit(state.copyWith(status: AuthStatus.failure));
    }
  }

  void logout() {
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  void checkAuthStatus() {
    emit(state);
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthState state) => state.toJson();
}

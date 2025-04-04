// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) => AuthState(
      status: $enumDecodeNullable(_$AuthStatusEnumMap, json['status']) ??
          AuthStatus.initial,
    );

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'status': _$AuthStatusEnumMap[instance.status]!,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.initial: 'initial',
  AuthStatus.loading: 'loading',
  AuthStatus.success: 'success',
  AuthStatus.failure: 'failure',
};

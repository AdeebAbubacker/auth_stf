// auth_event.dart

part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
   factory AuthEvent.started({
    required String username,
    required String password,
  }) = _Started;
}

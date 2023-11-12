// auth_state.dart

part of 'auth_bloc.dart';

// auth_state.dart

// auth_state.dart



@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required bool isLoading,
    required bool isError,
    User? user, // The authenticated user
  }) = _AuthState;

  factory AuthState.initial() {
    return AuthState(isLoading: false, isError: false, user: null);
  }

  factory AuthState.loading() {
    return AuthState(isLoading: true, isError: false, user: null);
  }

  const factory AuthState.success() = Success;

  factory AuthState.error(MainFailure failure) {
    return AuthState(isLoading: false, isError: true, user: null);
  }
}

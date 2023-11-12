import 'package:authentication/domain/auth/usermodel.dart';
import 'package:authentication/domain/auth/username.dart';
import 'package:authentication/domain/core/failure/mainfailure.dart';
import 'package:authentication/infrastructure/auth_repo_impl.dart';
import 'package:authentication/presentation/login.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';


@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepoImpl _userRepo;

  AuthBloc(this._userRepo) : super(AuthState.initial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    yield* event.map(
      started: (_Started event) async* {
        yield AuthState.loading(); // Notify UI that authentication is in progress

        final Either<MainFailure, User> auth =
            await _userRepo.auth(event.username, event.password);

        yield auth.fold(
          (failure) => AuthState.error(failure), // Notify UI about the error
          (user) => AuthState(user: user,isLoading: false,isError: false), // Notify UI about successful authentication
        );
      },
    );
  }
}

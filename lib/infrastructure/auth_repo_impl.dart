import 'package:authentication/domain/auth/usermodel.dart';
import 'package:authentication/domain/auth/username.dart';
import 'package:authentication/domain/core/failure/mainfailure.dart';
import 'package:authentication/presentation/login.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: UserRepo)
class UserRepoImpl implements UserRepo {
  @override
  Future<Either<MainFailure, User>> auth(String username, String password) async {
    try {
      final response = await Dio(BaseOptions()).post(
        'http://your-api-endpoint.com/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final userData = response.data['user'];
        final user = User(username: userData['username'], password: userData['password']);
        return right(user);
      } else {
        return left(const MainFailure.serverFailure());
      }
    } catch (e) {
      return left(const MainFailure.clientFailure());
    }
  }
}

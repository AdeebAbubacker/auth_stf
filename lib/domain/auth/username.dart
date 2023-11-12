// domain/user.dart

import 'package:authentication/domain/auth/usermodel.dart';
import 'package:authentication/domain/core/failure/mainfailure.dart';
import 'package:authentication/presentation/login.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo {
  Future<Either<MainFailure, User>> auth(String username, String password);
}

// class User {
//   final String username;
//   final String password;

//   User({required this.username, required this.password});
// }


import 'package:authentication/domain/core/dep_injection/dep_injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';



final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
   $initGetIt(getIt, environment: Environment.prod);
}
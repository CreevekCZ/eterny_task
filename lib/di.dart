import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final sl = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies() async => sl.init();

@module
abstract class AppModule {
  // This is place where I would dependencies that needs special configuration like Dio or GraphQL client
}

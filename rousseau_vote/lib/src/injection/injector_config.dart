import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector_config.iconfig.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configure() => $initGetIt(getIt);
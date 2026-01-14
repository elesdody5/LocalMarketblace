import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';


final dataGetIt = GetIt.instance;

/// Initializes data layer dependency injection
@InjectableInit(
  initializerName: 'initDataGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDataDependencies() => initDataGetIt(dataGetIt);


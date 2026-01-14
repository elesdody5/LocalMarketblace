import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';


final presentationGetIt = GetIt.instance;

/// Initializes presentation layer dependency injection
@InjectableInit(
  initializerName: 'initPresentationGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configurePresentationDependencies() => initPresentationGetIt(presentationGetIt);


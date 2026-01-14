import 'package:injectable/injectable.dart';

/// Data layer dependency injection module
/// This module registers all data layer dependencies (repositories implementations, data sources, APIs)
@module
abstract class DataModule {
  // Add your data layer dependencies here
  // Example:
  // @lazySingleton
  // Dio provideDio() => Dio(BaseOptions(baseUrl: 'https://api.example.com'));

  // @LazySingleton(as: AuthRepository)
  // AuthRepositoryImpl provideAuthRepository(AuthRemoteDataSource remoteDataSource) =>
  //     AuthRepositoryImpl(remoteDataSource);
}


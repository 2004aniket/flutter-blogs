import 'package:blog/core/cubits/AppUser/app_user_cubit.dart';
import 'package:blog/core/network/NetworkChecker.dart';
import 'package:blog/core/secrets.dart';
import 'package:blog/features/auth/data/datasources/remote_data_soureces.dart';
import 'package:blog/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/use_cases/getCurrentUser.dart';
import 'package:blog/features/auth/domain/use_cases/user_login.dart';
import 'package:blog/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_sources.dart';
import 'package:blog/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog/features/blog/domain/repository/blog_repository.dart';
import 'package:blog/features/blog/domain/use_cases/UploadBlog.dart';
import 'package:blog/features/blog/domain/use_cases/get_all_blogs.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  await _initAuth();
  await initblog();
  final supabase = await Supabase.initialize(
      url: Secrets.supabaseURl, anonKey: Secrets.supabaseAnonKey);

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<NetWorkChecker>(
      () => Networkcheckerimpl(serviceLocator()));
}

Future<void> _initAuth() async {
  serviceLocator.registerFactory<remoteDataSource>(
      () => RemoteDataSoureceImpl(serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()));

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator
      .registerFactory(() => UserLogin(authRepository: serviceLocator()));
  serviceLocator.registerFactory(() => Getcurrentuser(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      getcurrentUser: serviceLocator(),
      appUserCubit: serviceLocator()));
}

Future<void> initblog() async {
  serviceLocator
      .registerFactory<BlogRemoteDataSources>(() => BlogRemoteDataSourcesImpl(
            supabaseClient: serviceLocator(),
          ));
  serviceLocator.registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(blogRemoteDataSources: serviceLocator()));
  serviceLocator.registerFactory(() => Uploadblog(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetAllBlogs(blogRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() =>
      BlogBloc(uploadblog: serviceLocator(), getallblog: serviceLocator()));
}

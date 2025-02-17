import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterproject/data/data_providers/cars_data_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterproject/presentation/screen/WelcomeScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router.dart';
import 'data/data_providers/auth_data_provider.dart';
import 'data/data_providers/collections_data_provider.dart';
import 'data/data_providers/reviews_data_provider.dart';
import 'data/data_providers/users_data_provider.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/collections_repository.dart';
import 'data/repositories/Cars_repository.dart';
import 'data/repositories/reviews_repository.dart';
import 'data/repositories/users_repository.dart';
import 'logic/blocs/auth/auth_bloc.dart';
import 'logic/blocs/collection/collection_bloc.dart';
import 'logic/blocs/Cars/Cars_bloc.dart';
import 'logic/blocs/review/review_bloc.dart';
import 'logic/blocs/user/user_bloc.dart';
import 'logic/blocs/userSession/user_session_bloc.dart';
import 'logic/utils/bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(AuthDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => CarsRepository(CarsDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => CollectionsRepository(CollectionsDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => UsersRepository(UsersDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => ReviewsRepository(ReviewsDataProvider()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => UserSessionBloc(),
          ),
          // BlocProvider(
          //   create: (context) => CarsBloc(context.read<CarsRepository>()),
          // ),
          BlocProvider(
            create: (context) =>
                CollectionBloc(context.read<CollectionsRepository>()),
          ),
          BlocProvider(
            create: (context) => UserBloc(context.read<UsersRepository>()),
          ),
          BlocProvider(
            create: (context) => ReviewBloc(context.read<ReviewsRepository>()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: ThemeData(
            fontFamily: ('inter'),
            useMaterial3: true,
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.latoTextTheme(),
          ).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
            ),
          ),
          title: 'Car rental App',
        ),
      ),
    );
  }
}

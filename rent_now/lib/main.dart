import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/core/utils/router.dart';
import 'package:rent_now/features/address/presentation/bloc/address_bloc.dart';
import 'package:rent_now/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rent_now/features/auth/presentation/pages/splash_page.dart';
import 'package:rent_now/features/rent_post/presentation/bloc/rent_post_bloc.dart';
import 'package:rent_now/features/rent_request/presentation/bloc/rent_request_type_bloc.dart';
import 'package:rent_now/init_dep.dart';

void main() async {
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      BlocProvider(create: (_) => serviceLocator<RentPostBloc>()),
      BlocProvider(create: (_) => serviceLocator<AddressBloc>()),
      BlocProvider(create: (_) => serviceLocator<RentRequestTypeBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: getAppRoutes(),
      initialRoute: SplashPage.routeName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

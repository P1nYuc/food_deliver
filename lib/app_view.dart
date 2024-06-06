import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_deliver/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:food_deliver/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:food_deliver/screens/home/blocs/bloc/get_food_bloc.dart';
import 'package:food_repository/food_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'screens/auth/views/welcome_screen.dart';
import 'screens/home/views/home_screen.dart';
class MyAppView extends StatelessWidget {
  const MyAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(//MultiBlocProvider必須吂上面否則HomeScreen會找不到GetFoodBloc
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: FirebaseUserRepo(),
          ),
        ),
        BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(
            context.read<AuthenticationBloc>().userRepository,
          ),
        ),
        BlocProvider<GetFoodBloc>(
          create: (context) => GetFoodBloc(
            FirebaseFoodRepo(),
          )..add(GetFood()),
        ),
      ],
      child: MaterialApp(
        title: 'food_delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            surface: Color.fromARGB(255, 245, 245, 245),
            onSurface: Colors.black,
            primary: Colors.orange,
            onPrimary: Colors.white,
          ),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return HomeScreen();
            } else {
              return WelcomeScreen();
            }
          },
        ),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver/app.dart';
import 'package:food_deliver/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'package:food_repository/food_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp( MyApp(FirebaseUserRepo()));
}



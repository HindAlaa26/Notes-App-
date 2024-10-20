import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/note_cubit.dart';
import 'package:notes_app/screens/splash_screen.dart';

void main() {
   //WidgetsFlutterBinding.ensureInitialized();
  //await PreferenceHelper.init();
 
  runApp(BlocProvider(
    create: (context) => NotesCubit()..createDatabase(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
     home: SplashScreen()
    );
  }
}


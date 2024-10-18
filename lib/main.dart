import 'package:chat_tharwat/firebase_options.dart';
import 'package:chat_tharwat/pages/chat_page.dart';
import 'package:chat_tharwat/pages/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_tharwat/pages/cubits/chat/chat_cubit.dart';
import 'package:chat_tharwat/pages/login_page.dart';
import 'package:chat_tharwat/pages/resgister_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthCubit(),),BlocProvider(create: (context) => ChatCubit(),)],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage()
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}

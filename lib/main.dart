import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/home/widgets/bottom_bar.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:flutter_amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon_clone/routes/on_generates_route.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserToken();
  }

  void _loadUserToken() async {
    await context.read<UserAuthProvider>().getUserDate(context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('${context.read<UserAuthProvider>().user.token} user token');

    if (_isLoading) {
      return Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Image.asset('assets/imgs/amazon_in.png'),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoutes,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
          surface: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        buttonTheme:
            const ButtonThemeData(buttonColor: GlobalVariables.secondaryColor),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      initialRoute: context.watch<UserAuthProvider>().user.token.isEmpty
          ? AuthScreen.pageName
          : BottomBar.pageName,
    );
  }
}

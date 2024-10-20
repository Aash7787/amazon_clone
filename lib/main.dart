import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/controller/bloc/admin_bloc.dart';
import 'package:flutter_amazon_clone/features/admin/screen/admin_screen.dart';
import 'package:flutter_amazon_clone/common/widgets/bottom_navigation_bar_w.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:flutter_amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon_clone/routes/on_generates_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AdminBloc()),
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isLoading = true; // Set loading to true initially
  bool _noNetwork = false; // Set to true if no network is found

  @override
  void initState() {
    super.initState();
    _checkNetworkAndLoadUser();
  }

  Future<void> _checkNetworkAndLoadUser() async {
    // Check network status
    final connectivityResult = await Connectivity().checkConnectivity();

    // Check if there's no network
    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _noNetwork = true;
        _isLoading = false; // Loading complete, but no network
      });
      return;
    }

    // If network is available, load user data
    await context.read<UserAuthProvider>().getUserDate(context);

    setState(() {
      _isLoading = false; // Loading complete
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserAuthProvider>();
    final user = userProvider.user;

    log('User token: ${user.token}');

    // If no network is available, show "No network" message
    if (_noNetwork) {
      log('network');
      return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/imgs/no_network.jpg'),
              fit: BoxFit.fitWidth),
        ),
      );
    }

    // If still loading (fetching user data or checking network), show loading screen
    if (_isLoading) {
      log('loading');

      return Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/imgs/amazon_in.png'),
              const CircularProgressIndicator()
            ],
          ),
        ),
      );
    }

    // If everything is loaded, proceed to the appropriate screen based on user type
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoutes,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 29, 201, 192),
          surface: Color.fromARGB(255, 29, 201, 192),
        ),
        appBarTheme: const AppBarTheme(elevation: 0),
        buttonTheme:
            const ButtonThemeData(buttonColor: GlobalVariables.secondaryColor),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      // Navigate based on token availability and user type
      initialRoute: user.token.isNotEmpty
          ? user.type == 'user'
              ? BottomNavigationBarW.routeName
              : AdminScreen.routeName
          : AuthScreen.routeName,
    );
  }
}

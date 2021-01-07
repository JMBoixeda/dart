import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:emc2/models/config.dart';
import 'package:emc2/providers/auth.dart';
import 'package:emc2/providers/installation_set.dart';
import 'package:emc2/providers/config_provider.dart';
import 'package:emc2/providers/province_set.dart';

import 'package:emc2/routes.dart';
import 'package:emc2/theme.dart';

import 'package:emc2/screens/splash/splash_screen.dart';
import 'package:emc2/screens/splash_emc2_screen.dart';
import 'package:emc2/screens/auth_screen.dart';
import 'package:emc2/screens/installations_list_screen.dart';
import 'package:emc2/providers/projects.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool _showOnBoarding() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => new ConfigProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => new InstallationSet(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Provinces(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Projects(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'EMC2 - The Energy App',
          theme: theme(),
          home: ctx.watch<ConfigProvider>().config.showEngagement
              ? SplashScreen()
              : auth.isAuth
                  ? InstallationsListScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashEmc2Screen()
                              : AuthScreen(),
                    ),
          // initialRoute: auth.isAuth
          //               ? _showOnBoarding() ? SplashScreen.routeName
          //                   :InstallationsListScreen.routeName
          //               : SplashScreen.routeName,
          routes: routes,
        ),
      ),
    );
  }
}

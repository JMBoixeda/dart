import 'package:flutter/widgets.dart';

import 'package:emc2/screens/add_installation/add_installation_01_screen.dart';
import 'package:emc2/screens/add_installation/add_installation_02_screen.dart';
import 'package:emc2/screens/installation_detail_screen.dart';
import 'package:emc2/screens/splash/splash_screen.dart';
import 'package:emc2/screens/auth_screen.dart';
import 'package:emc2/screens/installations_list_screen.dart';
import 'package:emc2/screens/splash_emc2_screen.dart';
import 'package:emc2/screens/show_forecasted_offer_screen.dart';
import 'package:emc2/screens/project_detail_screen.dart';
import 'package:emc2/screens/graphics/graphics_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
    SplashScreen.routeName: (context) => SplashScreen(),
    SplashEmc2Screen.routeName: (context) => SplashEmc2Screen(),
    AuthScreen.routeName: (context) => AuthScreen(),
    InstallationsListScreen.routeName: (context) => InstallationsListScreen(),
    AddInstallation01Screen.routeName: (context) => AddInstallation01Screen(),
    AddInstallation02Screen.routeName: (context) => AddInstallation02Screen(),
    InstallationDetailScreen.routeName: (context) => InstallationDetailScreen(),
    ShowForecastedOfferScreen.routeName: (context) => ShowForecastedOfferScreen(),
    ProjectDetailScreen.routeName: (context) => ProjectDetailScreen(),
    GraphicsScreen.routeName: (context) => GraphicsScreen(),
};

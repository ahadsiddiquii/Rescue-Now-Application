import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes.dart';
import 'config/theme.dart';
import 'master_ui_module/splash_screen.dart';
import 'resources/blocs/ambulance_resources/ambulance_bloc.dart';
import 'resources/blocs/customer_bookings/customer_bookings_bloc.dart';
import 'resources/blocs/driver_bookings_resources/driver_bookings_bloc.dart';
import 'resources/blocs/driver_current_job_resources/driver_current_job_bloc.dart';
import 'resources/blocs/hospital_resources/hospital_bloc.dart';
import 'resources/blocs/master_blocs/user_resources/user_bloc.dart';
import 'resources/blocs/navigation_bar_resources/navigation_bar_bloc.dart';
import 'resources/blocs/order_resources/order_bloc.dart';
import 'resources/blocs/retrieve_ambulance_resources/retrieve_ambulances_bloc.dart';
import 'resources/blocs/retrieve_hospital_resources/retrieve_hospital_bloc.dart';
import 'resources/blocs/retrieve_order_resources/retrieve_order_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => UserBloc()..add(CheckIfLoggedIn()),
        ),
        BlocProvider(
          create: (BuildContext context) => NavigationBarBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => AmbulanceBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => RetrieveAmbulancesBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => HospitalBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => RetrieveHospitalBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => OrderBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => RetrieveOrderBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => DriverCurrentJobBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => CustomerBookingsBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => DriverBookingsBloc(),
        ),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          navigatorKey: App.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: theme,
          routes: routes,
          onGenerateRoute: (RouteSettings settings) {
            // print('build route for ${settings.name}');

            // var routes = <String, WidgetBuilder>{
            //   OrderChatScreen.route: (ctx) => OrderChatScreen(
            //       args: settings.arguments as Map<String, dynamic>),
            //   OrderChatScreenV2.route: (ctx) => OrderChatScreenV2(
            //       args: settings.arguments as Map<String, dynamic>),
            // };
            final WidgetBuilder builder = routes[settings.name]!;
            return MaterialPageRoute(
                builder: (BuildContext ctx) => builder(ctx));
          },
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes.dart';
import 'config/theme.dart';
import 'master_ui_module/splash_screen.dart';
import 'resources/blocs/master_blocs/user_resources/user_bloc.dart';

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

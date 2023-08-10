import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../customer_module/customer_home/customer_main_screen.dart';
import '../master_ui_module/main_screen/main_screen.dart';
import '../master_ui_module/phone_number_screen/enter_phone_number_screen.dart';
import '../resources/blocs/ambulance_resources/ambulance_bloc.dart';
import '../resources/blocs/driver_current_job_resources/driver_current_job_bloc.dart';
import '../resources/blocs/hospital_resources/hospital_bloc.dart';
import '../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../resources/blocs/navigation_bar_resources/navigation_bar_bloc.dart';
import '../resources/blocs/order_resources/order_bloc.dart';
import '../resources/blocs/retrieve_ambulance_resources/retrieve_ambulances_bloc.dart';
import '../resources/blocs/retrieve_hospital_resources/retrieve_hospital_bloc.dart';
import '../resources/blocs/retrieve_order_resources/retrieve_order_bloc.dart';
import 'local_storage.dart';

class Globals {
  static void mainScreenNavigationWhenNotLoggedIn(BuildContext context) {
    BlocProvider.of<NavigationBarBloc>(context).add(ChangeScreenInNavigationBar(
      indexOfItem: 0,
      role: 'Driver',
    ));
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainScreen.routeName,
      // ignore: always_specify_types
      (route) => false,
    );
  }

  static void customerMainScreenNavigationWhenNotLoggedIn(
      BuildContext context) {
    BlocProvider.of<NavigationBarBloc>(context).add(ChangeScreenInNavigationBar(
      indexOfItem: 0,
      role: 'Customer',
    ));
    Navigator.pushNamedAndRemoveUntil(
      context,
      CustomerMainScreen.routeName,
      // ignore: always_specify_types
      (route) => false,
    );
  }

  static void logout(BuildContext context) {
    BlocProvider.of<NavigationBarBloc>(context)
        .add(SetNavigationBarToInitial());
    BlocProvider.of<AmbulanceBloc>(context).add(SetAmbulanceBlocToInitial());
    BlocProvider.of<RetrieveAmbulancesBloc>(context)
        .add(SetRetrieveAmbulancesBlocToInitial());
    BlocProvider.of<HospitalBloc>(context).add(SetHospitalBlocToInitial());
    BlocProvider.of<RetrieveHospitalBloc>(context)
        .add(SetRetrieveHospitalsBlocToInitial());
    BlocProvider.of<OrderBloc>(context).add(SetOrderBlocToInitial());
    BlocProvider.of<RetrieveOrderBloc>(context)
        .add(SetRetrieveOrderBlocToInitial());
    BlocProvider.of<DriverCurrentJobBloc>(context)
        .add(SetDriverCurrentJobBlocToInitial());
    BlocProvider.of<UserBloc>(context).add(ResetStateToUserInitial());
    Storage.cleanData();
    Navigator.pushNamedAndRemoveUntil(
      context,
      EnterPhoneNumberScreen.routeName,
      (route) => false,
    );
  }
}

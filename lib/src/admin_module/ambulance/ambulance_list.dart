import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/rescue_divider.dart';
import '../../generic_widgets/rescue_now_appbar.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/ambulance_resources/ambulance_bloc.dart';
import '../../resources/blocs/retrieve_ambulance_resources/retrieve_ambulances_bloc.dart';
import '../../ui_config/decoration_constants.dart';
import 'register_ambulance.dart';

class AmbulanceListScreen extends StatefulWidget {
  const AmbulanceListScreen({Key? key}) : super(key: key);
  static const String routeName = '/ambulance_list_screen';

  @override
  State<AmbulanceListScreen> createState() => _AmbulanceListScreenState();
}

class _AmbulanceListScreenState extends State<AmbulanceListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RetrieveAmbulancesBloc>(context).add(GetAllAmbulances());
    // GetAllAmbulances
  }

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    return Scaffold(
      appBar: const RescueNowAppBar(
        titleText: 'Ambulance',
        isHamburger: false,
        showBackButton: true,
      ),
      body: InitScreen(
          child: BlocListener<AmbulanceBloc, AmbulanceState>(
        listener: (context, state) {
          if (state is AmbulanceDeleted) {
            BlocProvider.of<RetrieveAmbulancesBloc>(context)
                .add(GetAllAmbulances());
          }
        },
        child: BlocBuilder<RetrieveAmbulancesBloc, RetrieveAmbulancesState>(
          builder: (context, state) {
            if (state is RetrievingAmbulances) {
              return const Center(
                child: RescueNowCircularProgressIndicator(),
              );
            }
            if (state is RetrievedAllAmbulances) {
              return ListView.separated(
                primary: false,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return Card(
                    color: DecorationConstants.kAppBarColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Image.memory(base64Decode(
                                  state.allAmbulanceList[i].vehicleFrontImage)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RescueNowText(state.allAmbulanceList[i].plateNumber)
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<AmbulanceBloc>(context)
                                .add(DeleteAmbulance(
                              plateNumber:
                                  state.allAmbulanceList[i].plateNumber,
                            ));
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, i) {
                  return const RescueDivider();
                },
                itemCount: state.allAmbulanceList.length,
              );
            }
            return const SizedBox();
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: DecorationConstants.kThemeColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            RegisterAmbulanceScreen.routeName,
          );
        },
      ),
    );
  }
}

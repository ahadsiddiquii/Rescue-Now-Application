import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/rescue_now_appbar.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/hospital_resources/hospital_bloc.dart';
import '../../resources/blocs/retrieve_hospital_resources/retrieve_hospital_bloc.dart';
import '../../ui_config/decoration_constants.dart';
import 'register_hospital.dart';

class HospitalListScreen extends StatefulWidget {
  const HospitalListScreen({Key? key}) : super(key: key);
  static const String routeName = '/hospital_list_screen';

  @override
  State<HospitalListScreen> createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RetrieveHospitalBloc>(context).add(GetAllHospitals());
  }

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    return Scaffold(
      appBar: const RescueNowAppBar(
        titleText: 'Hospitals',
        isHamburger: false,
        showBackButton: true,
      ),
      body: InitScreen(
          child: BlocListener<HospitalBloc, HospitalState>(
        listener: (context, state) {
          if (state is HospitalDeleted) {
            BlocProvider.of<RetrieveHospitalBloc>(context)
                .add(GetAllHospitals());
          }
        },
        child: BlocBuilder<RetrieveHospitalBloc, RetrieveHospitalState>(
          builder: (context, state) {
            if (state is RetrievingHospitals) {
              return const Center(
                child: RescueNowCircularProgressIndicator(),
              );
            }
            if (state is RetrievedAllHospitals) {
              return ListView.separated(
                primary: false,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return Card(
                    color: DecorationConstants.kAppBarColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RescueNowText(
                                state.allHospitalsList[i].placeName,
                                style: ScreenConfig.theme.textTheme.titleLarge!
                                    .copyWith(
                                  color: DecorationConstants.kPrimaryTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                              ),
                              RescueNowText(
                                '${state.allHospitalsList[i].placeLatitude}, ${state.allHospitalsList[i].placeLongitude}',
                                style: ScreenConfig.theme.textTheme.titleLarge!
                                    .copyWith(
                                  color: DecorationConstants.kPrimaryTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<HospitalBloc>(context)
                                  .add(DeleteHospital(
                                hospitalId:
                                    state.allHospitalsList[i].hospitalId,
                              ));
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, i) {
                  return const SizedBox();
                },
                itemCount: state.allHospitalsList.length,
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
            RegisterHospitalScreen.routeName,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/rescue_now_appbar.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/blocs/retrieve_hospital_resources/retrieve_hospital_bloc.dart';
import '../../ui_config/decoration_constants.dart';
import 'add_ambulance_details.dart';

class SelectHospital extends StatelessWidget {
  const SelectHospital({
    Key? key,
    required this.userId,
    required this.emergencyLevel,
    required this.stress,
  }) : super(key: key);
  static const String routeName = '/select_hospital_screen';
  final String userId;
  final String emergencyLevel;
  final String stress;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RetrieveHospitalBloc>(context).add(GetAllHospitals());
    return Scaffold(
      appBar: RescueNowAppBar(
        isHamburger: false,
        titleText: 'Select Hospital',
        showBackButton: true,
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<RetrieveHospitalBloc, RetrieveHospitalState>(
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
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAmbulanceDetails(
                          userId: userId,
                          emergencyLevel: emergencyLevel,
                          stress: stress,
                          hospital: state.allHospitalsList[i],
                        ),
                      ),
                    );
                  },
                  child: Card(
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
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          )
                        ],
                      ),
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
    );
  }
}

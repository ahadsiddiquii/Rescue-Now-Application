import 'package:flutter/material.dart';

import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/buttons/wide_button.dart';
import '../../generic_widgets/drop_downs/drop_down_lists.dart';
import '../../generic_widgets/drop_downs/rescue_now_dropdown.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/rescue_now_appbar.dart';
import '../../generic_widgets/text_field_label.dart';
import '../../resources/models/hospital.dart';
import '../../ui_config/decoration_constants.dart';
import 'select_location.dart';

class AddAmbulanceDetails extends StatefulWidget {
  const AddAmbulanceDetails({
    Key? key,
    required this.userId,
    required this.emergencyLevel,
    required this.stress,
    required this.hospital,
  }) : super(key: key);
  static const String routeName = '/add_ambulance_details_screen';
  final String userId;
  final String emergencyLevel;
  final String stress;
  final Hospital hospital;

  @override
  State<AddAmbulanceDetails> createState() => _AddAmbulanceDetailsState();
}

class _AddAmbulanceDetailsState extends State<AddAmbulanceDetails> {
  String _selectedSizeValue = 'Big';
  String _selectedEquippedValue = 'Equipped';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RescueNowAppBar(
          isHamburger: false,
          titleText: 'Ambulance Details',
          showBackButton: true,
          onBackTap: () {
            Navigator.pop(context);
          },
        ),
        body: InitScreen(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFieldLabel(
                      labelText: 'Ambulance Size',
                      onTap: () {},
                    ),
                    AddHeight(
                        DecorationConstants.kWidgetSecondaryDistanceHeight),
                    RescueNowDropdown(
                      selectedItem: _selectedSizeValue,
                      onChange: (String? newValue) {
                        setState(() {
                          _selectedSizeValue = newValue!;
                        });
                      },
                      dropdownList: DropdownLists.ambulanceSizesList,
                    ),
                    AddHeight(DecorationConstants.kWidgetDistanceHeight),
                    TextFieldLabel(
                      labelText: 'Is Ambulance Equipped',
                      onTap: () {},
                    ),
                    AddHeight(
                        DecorationConstants.kWidgetSecondaryDistanceHeight),
                    RescueNowDropdown(
                      selectedItem: _selectedEquippedValue,
                      onChange: (String? newValue) {
                        setState(() {
                          _selectedEquippedValue = newValue!;
                        });
                      },
                      dropdownList: DropdownLists.ambulanceEquipmentList,
                    ),
                    AddHeight(
                        DecorationConstants.kWidgetSecondaryDistanceHeight),
                  ],
                ),
              ),
              AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
              WideButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectLocation(
                        userId: widget.userId,
                        emergencyLevel: widget.emergencyLevel,
                        stress: widget.stress,
                        hospital: widget.hospital,
                        ambulanceEquipped: _selectedEquippedValue,
                        ambulanceSize: _selectedSizeValue,
                      ),
                    ),
                  );
                },
                buttonText: 'Proceed',
              ),
            ],
          ),
        ));
  }
}

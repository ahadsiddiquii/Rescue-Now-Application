import 'package:flutter/material.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/text_widget.dart';

class RescueNowDropdown extends StatelessWidget {
  const RescueNowDropdown({
    Key? key,
    required this.selectedItem,
    required this.onChange,
    required this.dropdownList,
  }) : super(key: key);

  final String selectedItem;
  final Function(String?) onChange;
  final List<String> dropdownList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenConfig.screenSizeWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: DropdownButton<String>(
        items: dropdownList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              width: ScreenConfig.screenSizeWidth * 0.8,
              padding: const EdgeInsets.only(left: 12),
              child: RescueNowText(
                value,
                style: ScreenConfig.theme.textTheme.headlineSmall,
              ),
            ),
          );
        }).toList(),

        onChanged: (String? newValue) {
          onChange(newValue);
        },
        value: selectedItem,
        underline: const SizedBox(),
        hint: const SizedBox(), // Hint text when no option is selected
      ),
    );
  }
}

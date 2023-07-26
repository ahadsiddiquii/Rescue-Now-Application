// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/screen_config.dart';
import '../ui_config/decoration_constants.dart';
import 'text_field_label.dart';
import 'text_widget.dart';

// Project imports:

class RescueNowTextField extends StatefulWidget {
  const RescueNowTextField(
      {this.onChanged,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.validator,
      this.keyboadType,
      this.inputFormatters,
      this.label,
      this.isMobileField = false,
      this.isDescriptionField = false,
      this.isDirectionality = true,
      required this.hintText,
      this.controller,
      this.onTap,
      this.readOnly,
      this.customPadding,
      this.textCapitalization = TextCapitalization.none,
      Key? key})
      : super(key: key);
  final TextEditingController? controller;
  final String? label;
  final VoidCallback? onEditingComplete, onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboadType;
  final bool isMobileField;
  final bool isDescriptionField;
  final bool? readOnly;
  final bool isDirectionality;
  final EdgeInsets? customPadding;
  final TextCapitalization textCapitalization;
  final String hintText;

  @override
  State<RescueNowTextField> createState() => _RescueNowTextFieldState();
}

class _RescueNowTextFieldState extends State<RescueNowTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) TextFieldLabel(labelText: widget.label!),
        if (widget.label != null) const SizedBox(height: 10),
        Row(
          children: [
            if (widget.isMobileField)
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        DecorationConstants.kTextFieldHorizontalContentPadding -
                            4,
                    vertical:
                        DecorationConstants.kTextFieldVerticalContentPadding,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC2CADE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          DecorationConstants.kTextFieldBorderRadius),
                      bottomLeft: Radius.circular(
                          DecorationConstants.kTextFieldBorderRadius),
                    ),
                  ),
                  child: RescueNowText(
                    '+92',
                    style: ScreenConfig.theme.textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            Expanded(
              flex: 5,
              child: TextFormField(
                textCapitalization: widget.textCapitalization,
                controller: widget.controller,
                decoration: InputDecoration(
                  suffixIcon: widget.onTap != null
                      ? const Icon(
                          Icons.arrow_forward_ios,
                          color: DecorationConstants.kPrimaryTextColor,
                        )
                      : null,
                  hintText: widget.hintText,
                  hintStyle: ScreenConfig.theme.textTheme.headline4!.copyWith(
                    color: DecorationConstants.kGreySecondaryTextColor,
                  ),
                  isDense: true,
                  contentPadding: widget.customPadding ??
                      EdgeInsets.symmetric(
                        vertical: DecorationConstants
                            .kTextFieldVerticalContentPadding,
                        horizontal: DecorationConstants
                            .kTextFieldHorizontalContentPadding,
                      ),
                  border: widget.isMobileField
                      ? OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                DecorationConstants.kTextFieldBorderRadius),
                            bottomRight: Radius.circular(
                                DecorationConstants.kTextFieldBorderRadius),
                          ),
                        )
                      : null,
                  errorStyle: ScreenConfig.theme.textTheme.headline6!.copyWith(
                    color: DecorationConstants.kRedColor,
                  ),
                ),
                onTap: widget.onTap,
                readOnly: widget.onTap != null ||
                        widget.readOnly != null ||
                        widget.readOnly == true
                    ? true
                    : false,
                validator: widget.validator,
                onChanged: widget.onChanged,
                onEditingComplete: widget.onEditingComplete,
                onSaved: widget.onSaved,
                onFieldSubmitted: widget.onFieldSubmitted,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboadType,
                cursorColor: DecorationConstants.kThemeColor,
                minLines: widget.isDescriptionField ? 6 : null,
                maxLines: widget.isDescriptionField ? null : 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

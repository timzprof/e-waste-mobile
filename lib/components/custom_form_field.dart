import 'package:ewaste/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  String? label;
  final TextEditingController? controller;
  final String? validationText, initialValue;
  final AutovalidateMode? autoValidate;
  final String type;
  final bool Function()? extraValidation;
  final String obscuringCharacter;
  final bool obscureText;
  final Color fillColor;
  final int maxLines;
  bool enabled;

  final TextInputType? keyboardType;
  final InputBorder? customBorder;
  final Widget? suffixIcon, prefixIcon;
  final String? hintText;
  final TextStyle? hinTextStyle;
  final int? maxLength;

  CustomFormField(
      {super.key,
      this.controller,
      this.label,
      this.validationText,
      this.autoValidate,
      this.initialValue,
      this.type = 'text',
      this.obscureText = false,
      this.enabled = true,
      this.extraValidation,
      this.obscuringCharacter = '.',
      this.fillColor = const Color(0xFFFDFEFF),
      this.maxLines = 1,
      this.customBorder,
      this.suffixIcon,
      this.prefixIcon,
      this.hinTextStyle,
      this.keyboardType,
      this.maxLength,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (label != null) ...[
        Text(label!,
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: Color(0xFF1F1F1F),
              fontSize: 14,
            )),
        const SizedBox(height: 10),
      ],
      Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(69, 108, 208, 0.09),
                spreadRadius: 0,
                blurRadius: 26,
                offset: Offset(2, 4), // changes position of shadow
              ),
            ],
          ),
          child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              autovalidateMode: autoValidate,
              obscuringCharacter: obscuringCharacter,
              obscureText: obscureText,
              initialValue: initialValue,
              readOnly: !enabled,
              //maxLength: maxLength,
              keyboardType: keyboardType ?? TextInputType.text,
              decoration: InputDecoration(
                  isDense: true,
                  border: customBorder ??
                      const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3CB62A)),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                  fillColor: fillColor,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  hintText: hintText,
                  hintStyle: hinTextStyle),
              validator: (value) {
                bool isInvalid = value == null ||
                    value.isEmpty ||
                    value.trim().isEmpty ||
                    (extraValidation != null ? extraValidation!() : false) ||
                    (type == 'email' ? !value.trim().isValidEmail() : false);
                if (isInvalid) {
                  return validationText ?? "Fill in the required field";
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength),
              ]))
    ]);
  }
}

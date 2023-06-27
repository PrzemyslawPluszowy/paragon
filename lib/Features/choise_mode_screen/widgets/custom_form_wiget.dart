import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.isClickable = true,
    required this.labelTextl,
    this.keyboardType = TextInputType.text,
    this.value,
    this.onChanged,
    this.onTap,
  });
  final bool isClickable;
  final String labelTextl;
  final TextInputType keyboardType;
  final String? value;
  final Function(String)? onChanged;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      child: TextFormField(
        style: const TextStyle(color: FigmaColorsAuth.white),
        controller: TextEditingController(text: value),
        onChanged: (value) async {},
        onTap: () {
          isClickable ? null : FocusScope.of(context).requestFocus(FocusNode());
          onTap != null ? onTap!() : null;
        },
        readOnly: !isClickable,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: FigmaColorsAuth.white),
          ),

          // filled: true,
          fillColor: FigmaColorsAuth.white,
          labelText: labelTextl,
          labelStyle: const TextStyle(color: FigmaColorsAuth.white),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: BorderSide(color: FigmaColorsAuth.darkFiolet)),
          // enabledBorder: const OutlineInputBorder(
          //     borderSide: BorderSide(color: FigmaColorsAuth.darkFiolet)),
        ),
      ),
    );
  }
}

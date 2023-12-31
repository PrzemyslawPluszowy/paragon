import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.isClickable = true,
    required this.labelTextl,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.validator,
    this.onChanged,
    required this.textEditingController,
  });
  final bool isClickable;
  final String labelTextl;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      child: TextFormField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: textEditingController,
        style: const TextStyle(color: Color.fromARGB(255, 46, 20, 81)),
        onTap: () {
          isClickable ? null : FocusScope.of(context).requestFocus(FocusNode());
          onTap != null ? onTap!() : null;
        },
        validator: validator,
        readOnly: !isClickable,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          errorStyle:
              TextStyle(color: FigmaColorsAuth.darknessFiolet.withOpacity(0.7)),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: FigmaColorsAuth.darkFiolet),
          ),
          fillColor: FigmaColorsAuth.white,
          labelText: labelTextl,
          labelStyle: const TextStyle(color: FigmaColorsAuth.darkFiolet),
        ),
      ),
    );
  }
}

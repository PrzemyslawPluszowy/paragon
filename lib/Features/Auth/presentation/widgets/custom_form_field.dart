import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.width,
    required this.label,
    this.obscureText = false,
    required this.insideIcon,
    this.keyboardType = TextInputType.name,
    this.isError = false,
    required this.onChanged,
  }) : super(key: key);

  final double width;
  final String label;
  final bool obscureText;
  final IconData insideIcon;
  final TextInputType keyboardType;
  final bool isError;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        width: width * 0.9,
        height: 60,
        child: TextFormField(
          style: const TextStyle(color: FigmaColorsAuth.white, fontSize: 15),
          cursorColor: FigmaColorsAuth.white,
          textAlign: TextAlign.left,
          autocorrect: true,
          keyboardType: TextInputType.name,
          obscureText: obscureText,
          onChanged: (value) {
            onChanged(value);
          },
          decoration: InputDecoration(
              suffixIcon: isError
                  ? const Icon(Icons.error_rounded,
                      color: FigmaColorsAuth.white)
                  : null,
              prefixIcon: Icon(insideIcon, color: FigmaColorsAuth.white),
              labelStyle:
                  const TextStyle(color: FigmaColorsAuth.white, fontSize: 15),
              label: Text(label,
                  style: const TextStyle(color: FigmaColorsAuth.white)),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              fillColor: FigmaColorsAuth.white.withOpacity(0.2),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: FigmaColorsAuth.white,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: FigmaColorsAuth.white,
                    width: 1,
                    style: BorderStyle.solid),
              ),
              disabledBorder: const OutlineInputBorder(),
              isDense: true),
        ));
  }
}

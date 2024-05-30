import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, this.hintText, this.labelText, this.onChanged});

  final String? hintText;
  final String? labelText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data)
      {
        if (data!.isEmpty)
        {
          return 'This field is required';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        hintStyle: const TextStyle(
          color: Color(0xffC7EDE6),
        ),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffC7EDE6),
          ),
        ),
      ),
    );
  }
}

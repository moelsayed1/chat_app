import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final Function(String)? onChanged;

  const PasswordTextField({super.key, this.onChanged, this.hintText, this.labelText});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  String? password;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
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
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xffC7EDE6),
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}

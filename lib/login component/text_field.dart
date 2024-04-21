import 'package:flutter/material.dart';

class mytextfield extends StatelessWidget {
  final String? Function(String?)? validator;
  final String hintText;
  final  Controller;
  final bool obscureText;
  const mytextfield({super.key, required this.hintText, this.Controller, required this.obscureText, this.validator});

  @override
  Widget build(BuildContext context) {
    return 
       Padding(
        
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: TextFormField(
    validator:validator,
    controller: Controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      fillColor: Colors.grey.shade200,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[500],)
    ),
  ),
);
    
  }
}
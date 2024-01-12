// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'coustom_text_field_border.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key, required this.title, this.onChanged,
  }) : super(key: key);
  final String title;
  final void Function(String)? onChanged;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value!.isEmpty){
          return 'field is required';
        }else{
          if(title=='Password'){
            if(value.length<6){
              return 'Password should be at least 6 characters';
            }
          }
          
        }
      },
      onChanged: onChanged,
      keyboardType: title=='Password'? TextInputType.visiblePassword:TextInputType.emailAddress,
      obscureText: title=='Password',
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(color: Colors.white70),
        border: coustomBorder(),
        enabledBorder: coustomBorder(),
        focusedBorder: coustomBorder(),
      ),
    );
  }
}
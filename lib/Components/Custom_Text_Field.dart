import 'package:chat_app/Constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key, required this.hint, this.onChanged , this.obscureText= false});

  final String? hint;
  final Function(String)? onChanged;
  bool? obscureText ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField (
        obscureText: obscureText!,
        validator: (String? data){
          if(data!.isEmpty){
            return 'this field is required';
          }
        },
        onChanged: onChanged,
        style: TextStyle(
          color: Colors.white,
          fontFamily: appFont
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: appFont
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.5
              )
          ),
          enabledBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.5
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.5
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.red,
                  width: 3
              )
          ),
        ),
      ),
    );

  }
}

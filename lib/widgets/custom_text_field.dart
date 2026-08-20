import 'package:flutter/material.dart';
import 'package:untitled1/utiles/app_colors.dart';

typedef OnValidator = String? Function(String?)? ;

class CustomTextField extends StatelessWidget {
  final double? radius ;
  final Color? borderColor ;
  final String? hintText ;
  final String? labelText ;
  final TextStyle? hintStyle ;
  final TextStyle? labelStyle ;
  final Color? filledColor ;
  final bool? fill ;
  final Widget? prefixIcon ;
  final Widget? suffixIcon;
  final int? maxLines ;
  final TextEditingController? controller ;
  Function(String)? onChanged ;
  final OnValidator validator ;
  TextInputType? keyboardType;
  final bool obscureText;

  CustomTextField({super.key,  this.radius , this.borderColor ,
    this.hintText , this.labelText , this.hintStyle , this.labelStyle,
    this.filledColor , this.fill= false , this.prefixIcon
    , this.suffixIcon , this.maxLines = 1, this.controller
    , this.onChanged , this.validator , this.obscureText = false
    , this.keyboardType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: builtDecorationItem(radius: radius ?? 16 ,
            borderColor: borderColor?? AppColors.strokeWhiteColor ),
        focusedBorder: builtDecorationItem(radius: radius ?? 16 ,
            borderColor: borderColor?? AppColors.strokeWhiteColor ),
        errorBorder: builtDecorationItem(radius: radius ?? 16 ,
            borderColor: AppColors.redColor),
        focusedErrorBorder: builtDecorationItem(radius: radius ?? 16 ,
            borderColor: AppColors.redColor ),
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        fillColor: filledColor,
        filled: fill,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged ,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: '*',
    );
  }
  OutlineInputBorder builtDecorationItem({required double radius,
  required Color borderColor}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: borderColor,
        width: 2
      ),
    );
  }
}

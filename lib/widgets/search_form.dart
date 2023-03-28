import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({ Key? key,this.name, this.controller, this.enable, this.onChanged}) : super(key: key);
 final String? name;
  final TextEditingController? controller;
  final bool? enable;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:55,
      child: TextField(
        readOnly:enable ?? false,
        onChanged: onChanged,
        decoration:InputDecoration(
          hintText: name,
              // prefixIcon: ,
              filled: true,
              fillColor: Colors.white,
              floatingLabelStyle:const TextStyle(
              ),
            contentPadding:const EdgeInsets.only(left:18,bottom: 47 / 2),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Image.asset("assets/icons/Group 18.png"),
                ),
            ),
              border:const OutlineInputBorder(
                borderSide: BorderSide.none,       
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ) ,

      ),
      
    );
  }
}
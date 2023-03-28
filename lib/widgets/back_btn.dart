// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            // height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1,
                color: Colors.black
              ),
              borderRadius: BorderRadius.circular(4)
            ),
            child: Icon(Icons.arrow_back, size: 16, color: Colors.black.withOpacity(0.7),),
          ),
        ),
      ),
    );
  }
}
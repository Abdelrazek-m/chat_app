
import 'package:flutter/material.dart';
import 'package:scholar_chat/constant.dart';

class CustomBotton extends StatelessWidget {
  const CustomBotton({
    Key? key, required this.title, this.onTap,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: kMainColor,
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}

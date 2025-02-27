import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? OnTap;
  const SquareTile({
    super.key, 
    required this.imagePath,
    required this.OnTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        padding:const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white
            ),
            borderRadius: 
            BorderRadius.circular(16),
            color: Colors.grey[200]
          ),
        child: Image.asset(
          imagePath,
        height: 40,
        ),
      ),
    );
  }
}
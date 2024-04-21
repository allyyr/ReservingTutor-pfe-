import 'package:flutter/material.dart';

class mybtn extends StatelessWidget {
 final void Function()? onTap;
  const mybtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(color: Colors.black,
        borderRadius: BorderRadius.circular(15)),
        
        
        child: const Center(
          child: Text("Login",style: TextStyle(color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          ),),
          
        ),
      ),
    );
  }
}
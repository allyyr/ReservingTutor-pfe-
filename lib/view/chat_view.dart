import 'package:flutter/material.dart';
import 'package:sapfd/util/color.dart';

class chatView extends StatelessWidget {
  const chatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.blue,
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Text('data')
            ],
          )
           ),
      ),
    );
  }
}
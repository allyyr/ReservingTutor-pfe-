import 'package:flutter/material.dart';
import 'package:sapfd/util/color.dart';

class informationView extends StatelessWidget {
  const informationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.blue,
        title: const Text(
          'Informations',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(),
            )
          ],
        ),
      ),
    );
  }
}
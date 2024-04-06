import 'package:flutter/material.dart';
import 'package:sapfd/util/color.dart';

// ignore: camel_case_types
class Notification_view extends StatelessWidget {
  const Notification_view({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: appBar(),
      body: listView(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppColors.blue,
      title: const Text(
        'Notifications',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget listView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return listViewItem(index);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
          );
        },
        itemCount: 15);
  }

  Widget listViewItem(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(index),
                  timeAndData(index),
                  messagee(index),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget message(int index) {
    double textsize = 14;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Message',
          style: TextStyle(
            fontSize: textsize,
            color: Colors.black,
            fontWeight: FontWeight.bold,)
          
          ),
          
          ],
      
      
    );
  }
   Widget messagee(int index) {
    double textsize = 14;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
          Text('Message description',
          style: TextStyle(
            fontSize: textsize,
            
            fontWeight: FontWeight.w400,)
          
          ),
    
          ],
      
      
    );
  }

  Widget timeAndData(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '26-03-2024',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          Text(
            '7:10 AM',
            style: TextStyle(
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 100,
      width: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Icon(
        Icons.notifications,
        size: 25,
        color: Colors.grey.shade700,
      ),
    );
  }
}

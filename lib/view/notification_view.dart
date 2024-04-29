import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sapfd/util/color.dart';
import 'package:intl/intl.dart';

class Notification_view extends StatelessWidget {
  const Notification_view({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: reservationRequestList(),
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

  Widget reservationRequestList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('reservation_requests')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<QueryDocumentSnapshot> reservationRequests = snapshot.data!.docs;

        if (reservationRequests.isEmpty) {
          return Center(
            child: Text('No reservation requests found.'),
          );
        }

        return ListView.separated(
          itemBuilder: (context, index) {
            return reservationRequestItem(reservationRequests[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
          itemCount: reservationRequests.length,
        );
      },
    );
  }

  Widget reservationRequestItem(QueryDocumentSnapshot reservationRequest) {
    Map<String, dynamic> data =
        reservationRequest.data() as Map<String, dynamic>;
    Timestamp timestamp = data['date'] ?? Timestamp.now();
    String description = data['description'] ?? '';
    DateTime date = timestamp.toDate();
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    String time = DateFormat('hh:mm a').format(date);

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
                  title(),
                  timeAndData(formattedDate, time),
                  message(description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget title() {
    return Text(
      'Reservation Request',
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget message(String description) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget timeAndData(String date, String time) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
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

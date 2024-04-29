import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sapfd/filterComponent/FilterPage.dart';
import 'package:sapfd/util/color.dart';
import 'package:sapfd/util/custom_element.dart';
import 'package:sapfd/view/Teacherviews/BottomSheetWidget.dart';

class highSchool extends StatefulWidget {
  const highSchool({super.key});

  @override
  State<highSchool> createState() => _highSchoolState();
}

class _highSchoolState extends State<highSchool> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _tutorsStream;

// Add this method to dispose the stream controller when no longer needed
  late String tutornameF = '';
  late int _selectedYear;
  int selectedIndex = -1;
  int tutorCount = 0;
  StreamController<QuerySnapshot<Map<String, dynamic>>>
      _filteredTutorsStreamController = StreamController();
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Load all tutors initially
    _tutorsStream = FirebaseFirestore.instance
        .collection('levels')
        .doc('highschool')
        .collection('tutors')
        .snapshots();
    tutorCount = 0;
    /*   _tutorsStreamController = StreamController<
        List<DocumentSnapshot<Map<String, dynamic>>>>.broadcast(); */
    _tutorsStream.listen((snapshot) {
      // Update tutor count when the stream emits new data
      setState(() {
        tutorCount = snapshot.size;
      });
    });

    _selectedYear = -1;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.blue,
        title: const Text(
          'High School',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.009,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    GestureDetector(
                      onTap: () {
                        _selectedYear = 1;
                        showTutorsByTeachingYear(_selectedYear);
                      },
                      child: chooseLevel(
                        level: '1 AP',
                        isSelected: _selectedYear == 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectedYear = 2;
                        showTutorsByTeachingYear(_selectedYear);
                      },
                      child: chooseLevel(
                        level: '2 AP',
                        isSelected: _selectedYear == 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectedYear = 3;
                        showTutorsByTeachingYear(_selectedYear);
                      },
                      child: chooseLevel(
                        level: '3 AP',
                        isSelected: _selectedYear == 3,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("$tutorCount Tutor"),
                        Row(
                          children: [
                            Text(
                              "Filter",
                              style: TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  final filterOptions = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FilterPage()),
                                  );
                                  if (filterOptions != null) {
                                    // Check if TutorName is provided in filterOptions
                                    tutornameF = filterOptions.TutorName;
                                    print(
                                        'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ$tutornameF');
                                    // Call filterTutorsByName method if TutorName is provided
                                    filterTutors(filterOptions);
                                  }
                                },
                                child: Container(
                                  height: size.height * 0.03,
                                  width: size.height * 0.04,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                  ),
                                  child: Icon(
                                    Icons.filter_list,
                                    color: AppColors.blue,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),

            // Your other UI elements here...
            const Divider(),
            // Use StreamBuilder to listen for changes in Firestore collection

            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _tutorsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                final tutors = snapshot.data!.docs;

                return SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.78,
                  child: GridView.count(
                    childAspectRatio: 1.38,
                    mainAxisSpacing: 15,
                    crossAxisCount: 1,
                    children: [
                      for (var tutor in tutors)
                        if (tutor['name'] != null &&
                            (tutor['name']
                                    .toLowerCase()
                                    .split(' ')
                                    .first
                                    .startsWith(tutornameF.toLowerCase()) ||
                                tutor['name']
                                    .toLowerCase()
                                    .split(' ')
                                    .last
                                    .startsWith(tutornameF.toLowerCase())))
                          drAnnonce(
                            onTap: () {
                              print('drAnnonce ************** tapped');
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    child: Container(
                                      child: BottomSheet(
                                        onClosing: () {},
                                        builder: (BuildContext context) {
                                          print(tutor['Location'].toString());
                                          final Map<String, dynamic>
                                              teachingScheduleData =
                                              tutor['teachingSchedule'] ?? {};
                                          final Map<String, List<String>>
                                              teachingSchedule = {};
                                          teachingScheduleData
                                              .forEach((day, time) {
                                            if (time is List<String>) {
                                              teachingSchedule[day] = time;
                                            } else if (time is String) {
                                              teachingSchedule[day] = [time];
                                            }
                                          });

                                          return BottomSheetWidget(
                                            price: tutor['pricePerMonth']
                                                .toString(),
                                            name: tutor['name'] ??
                                                'Unknown Tutor',
                                            imageUrl: 'images/p1.png',
                                            description: tutor['description'],
                                            TeachingDays: teachingSchedule,
                                            latlng: LatLng(
                                                tutor['Location'].latitude,
                                                tutor['Location'].longitude),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            image: 'images/highSchool.png',
                            nom: tutor['name'] ?? 'Unknown Tutor',
                            availability: tutor['availability'] ?? false,
                            nomModule: tutor['Subject'] ?? '',
                            prix: tutor['pricePerMonth'].toString(),
                            phoneNumber: tutor['phoneNumber'],
                            tutorid: tutor.id,
                          ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showTutorsByTeachingYear(int selectedYear) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('levels')
              .doc('highschool')
              .collection('tutors')
              .where('teachingLevel',
                  isEqualTo: selectedYear) // Filter by selectedYear
              .get();

      // Print all document IDs

      querySnapshot.docs.forEach((doc) {
        print(doc.id); // Print document ID
      });

      setState(() {
        _tutorsStream =
            Stream.value(querySnapshot); // Update the stream with filtered data
        tutorCount = querySnapshot.size;
      });
    } catch (error) {
      print('Error filtering tutors: $error');
      throw error;
    }
  }

  Map<String, List<String>> getTeachingSchedule(Map<String, dynamic>? tutors) {
    final Map<String, dynamic> teachingScheduleData =
        tutors?['teachingSchedule'] ?? {};
    final Map<String, List<String>> teachingSchedule = {};
    print('Teaching inside meth..... Schedule: $teachingScheduleData');
    teachingScheduleData.forEach((day, time) {
      if (time is List<String>) {
        teachingSchedule[day] = time;
      } else if (time is String) {
        teachingSchedule[day] = [time];
      }
    });

    return teachingSchedule;
  }

  Future<void> filterTutors(FilterOptions filterOptions) async {
    print('filter options : ${filterOptions.toString()}');
    try {
      print('selectedModules: ${filterOptions.selectedModules}');
      print('selectedModules: ${filterOptions.city}');
      print('tutorName: ${filterOptions.TutorName}');

      // Fetch all tutors
      Query<Map<String, dynamic>> query = FirebaseFirestore.instance
          .collection('levels')
          .doc('highschool')
          .collection('tutors')
          .where('pricePerMonth',
              isGreaterThanOrEqualTo: filterOptions.minPrice)
          .where('pricePerMonth', isLessThanOrEqualTo: filterOptions.maxPrice);

      // Filter by selected modules (subjects)
      if (filterOptions.selectedModules != null &&
          filterOptions.selectedModules!.isNotEmpty) {
        for (var module in filterOptions.selectedModules!) {
          query = query.where('Subject', isEqualTo: module);
        }
      }

      // Filter by city if provided
      if (filterOptions.city != null && filterOptions.city!.isNotEmpty) {
        // Extract city name from the city string
        String cityName = filterOptions.city!.split('. ')[1].split(' (')[0];
        query = query.where('city', isEqualTo: cityName);
      }

      // Execute the query
      QuerySnapshot<Map<String, dynamic>> filteredSnapshot = await query.get();

      // Update the UI with filtered tutors
      setState(() {
        _tutorsStream = Stream.value(filteredSnapshot);
      });
    } catch (error) {
      print('Error filtering tutors: $error');
      // Handle errors
    }
  }
}

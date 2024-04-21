import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:sapfd/filterComponent/DaySelector.dart';
import 'package:sapfd/filterComponent/ModuleSelector.dart';
import 'package:sapfd/filterComponent/city_option.dart';

class FilterPage extends StatefulWidget {
  //final String selectedLevel;
  const FilterPage({
    Key? key,
    //required this.selectedLevel,
  }) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late double _minPrice;
  late double _maxPrice;
  late RangeValues _selectedRange;
  late List<int> _selectedYears;
  String? _selectedCity;

  String? tutorName; // Initializing with null
  late Stream<QuerySnapshot<Map<String, dynamic>>>
      _tutorsStream; // Initialize here
  int _filteredTeacherCount = 0;
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _minPrice = 0;
    _maxPrice = 10000;
    _selectedRange = const RangeValues(0, 10000);
    _selectedCity = null;
    _selectedYears = []; // Initialize selected years as an empty list
    _tutorsStream = FirebaseFirestore.instance.collection('tutors').snapshots();
  }

  List<String> _selectedDays = [];
  List<String> _selectedModules = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50, left: 25),
              child: Row(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color.fromARGB(
                              255, 25, 162, 183), // Change the color to grey
                          size: 40, // Increase the size of the icon
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 20, // Change the font size to 20
                          color: Color.fromARGB(
                              255, 25, 162, 183), // Change the color to grey
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 40, left: 25, right: 25),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                border: Border.all(
                  color: const Color.fromARGB(255, 25, 162, 183),
                  width: 3,
                ),
              ),
              child: TextField(
                controller: _searchController, // Assign the controller
                onChanged: (value) {
                  setState(() {
                    // Update tutorName whenever the text changes
                    tutorName = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 25, 162, 183),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const SizedBox(
              height: 20,
            ),
            ModuleSelector(
              onSelectionChanged: (List<String> selectedModules) {
                setState(() {
                  _selectedModules = selectedModules; // Update selected days
                });
              },
            ),
            const SizedBox(height: 20),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Price Range: \$${_selectedRange.start.toInt()} - \$${_selectedRange.end.toInt()}',
              style: const TextStyle(
                fontSize: 18, // Same as previous
                color: Color.fromARGB(
                    255, 25, 162, 183), // Use a darker shade of grey
                fontWeight: FontWeight.normal, // Same as previous
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),
            SliderTheme(
              data: const SliderThemeData(
                activeTrackColor: Color.fromARGB(
                    255, 25, 162, 183), // Set the active track color to blue
                thumbColor: Color.fromARGB(
                    255, 25, 162, 183), // Set the thumb color to blue
              ),
              child: RangeSlider(
                values: _selectedRange,
                min: _minPrice,
                max: _maxPrice,
                onChanged: (RangeValues values) {
                  setState(() {
                    _selectedRange = values;
                  });
                },
                onChangeEnd: (RangeValues values) {
                  // Handle the end of slider movement if needed
                },
                labels: RangeLabels(
                  '\$${_selectedRange.start.toInt()}',
                  '\$${_selectedRange.end.toInt()}',
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            const Divider(
              // Add a divider
              color: Color.fromARGB(255, 218, 213, 213),
              thickness: 1,
              height: 1,
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                "Chose city",
                style: TextStyle(
                  fontSize: 22, // Increase the font size
                  color: Color.fromARGB(
                      255, 61, 60, 60), // Change the color to grey

                  fontWeight: FontWeight.normal, // Remove the bold font weight
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromARGB(255, 25, 162, 183),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedCity,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCity = newValue;
                      });
                    },
                    items: cityOptions // Add your city options here
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            const SizedBox(
              height: 20,
            ),
            DaySelector(
              onSelectionChanged: (List<String> selectedDays) {
                setState(() {
                  _selectedDays = selectedDays; // Update selected days
                });
              },
            ),
            // Add additional widgets here
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 55),
              child: GestureDetector(
                onTap: () {
                  print('FFFFFFFFFFFFFFFFFFFFFF  :$tutorName');
                  final filterOptions = FilterOptions(
                    minPrice: _selectedRange.start,
                    maxPrice: _selectedRange.end,
                    city: _selectedCity,
                    selectedDays: _selectedDays,
                    selectedModules: _selectedModules,
                    TutorName: tutorName ?? '',

                    //availability: _selectedAvailability,
                  );
                  Navigator.pop(
                      context, filterOptions); // Pass the filter options back
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 25, 162, 183),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Confirm Filter',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20), // Additional space after the button
          ],
        ),
      ),
    );
  }
}

class FilterOptions {
  final double minPrice;
  final double maxPrice;
  final String? city;
  final List<String> selectedDays;
  final List<String> selectedModules;
  final String TutorName;
  // Include selected days in filter options

  FilterOptions({
    required this.minPrice,
    required this.maxPrice,
    this.city,
    required this.selectedDays,
    required this.selectedModules,
    required this.TutorName,
  });
}

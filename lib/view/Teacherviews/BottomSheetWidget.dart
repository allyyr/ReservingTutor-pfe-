import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sapfd/view/Teacherviews/DaySelector.dart';
import 'package:sapfd/view/Teacherviews/TeacherinMap.dart';

class BottomSheetWidget extends StatefulWidget {
  final String name;
  final String imageUrl;
  final dynamic price;
  final String description;
  final Map<String, List<String>> TeachingDays;
  final LatLng latlng;

  const BottomSheetWidget({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.TeachingDays,
    required this.latlng,
  }) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = BottomSheet.createAnimationController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BottomSheet(
      animationController: _animationController,
      onClosing: () {},
      builder: (context) => Container(
        // height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 25, 162, 183), // Border color
            width: 2, // Border width
          ),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
          //color: Colors.white,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: const DecorationImage(
                              image: AssetImage('images/p1.png'),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Color.fromARGB(
                                  255, 25, 162, 183), // Border color
                              width: 2, // Border width
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 13, 83, 94),
                        ),
                      ),
                      const Divider(
                        // Add a divider
                        color: Color.fromARGB(255, 25, 162, 183),
                        thickness: 1,
                        height: 2,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Column(
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      color: Color.fromARGB(255, 25, 162, 183),
                                    ),
                                    Text(
                                      "Verified",
                                      style: TextStyle(),
                                    ),
                                  ],
                                ),
                                const Column(
                                  children: [
                                    Text(
                                      "4,2",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 25, 162, 183),
                                      ),
                                    ),
                                    Text(
                                      "Rating",
                                      style: TextStyle(),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${widget.price}\ DA',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 25, 162, 183),
                                      ),
                                    ),
                                    const Text(
                                      "Permonth",
                                      style: TextStyle(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        // Add a divider
                        color: Color.fromARGB(255, 25, 162, 183),
                        thickness: 1,
                        height: 2,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "About me",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 25, 162, 183),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.description,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 13, 83, 94),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ), /////////////////////////////////////////////
                      const Divider(
                        // Add a divider
                        color: Color.fromARGB(255, 25, 162, 183),
                        thickness: 1,
                        height: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 25, 162, 183),
                              width: 3), // Add grey border
                          borderRadius: BorderRadius.circular(5),
                          // Add border radius
                        ),
                        child: GestureDetector(
                          onTap: () {
                            print(widget.TeachingDays);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  elevation: 0, // Remove elevation
                                  backgroundColor: const Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255), // Set background color to white
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  content: SizedBox(
                                    width: 300, // Adjust width as needed
                                    height: 300, // Adjust height as needed
                                    child: DaySelectorTeacher(
                                      teachingDays: widget.TeachingDays,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14), // Add padding to the container
                            alignment:
                                Alignment.center, // Align text to the center
                            child: const Text(
                              'See my schedule',
                              style: TextStyle(
                                  fontSize: 18, // Set text size
                                  color: Color.fromARGB(255, 7, 73, 83),
                                  fontWeight:
                                      FontWeight.w500 // Set text color to black
                                  ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Location",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 25, 162, 183),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //
                            TeacherInMap(
                              teacherLocation: widget.latlng,
                              teacherName: widget.name,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Add your buttons here
            const twoButtonsSheet(),
          ],
        ),
      ),
    );
  }
}

class twoButtonsSheet extends StatelessWidget {
  const twoButtonsSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey, width: 2), // Add grey border
                borderRadius: BorderRadius.circular(5), // Add border radius
              ),
              child: GestureDetector(
                onTap: () {
                  // Handle tap on the first button
                },
                child: Container(
                  padding:
                      const EdgeInsets.all(10), // Add padding to the container
                  child: const Icon(
                    Icons.message,
                    color: Colors.black, // Set icon color to black
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10), // Add some space between buttons
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 3), // Add black border
                borderRadius: BorderRadius.circular(5), // Add border radius
              ),
              child: GestureDetector(
                onTap: () {
                  // Handle tap on the second button
                },
                child: Container(
                  color: const Color.fromARGB(255, 196, 127, 144),
                  padding:
                      const EdgeInsets.all(10), // Add padding to the container
                  alignment: Alignment.center, // Align text to the center
                  child: const Text(
                    'join  class',
                    style: TextStyle(
                      fontSize: 20, // Increase text size
                      color: Colors.black, // Set text color to black
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

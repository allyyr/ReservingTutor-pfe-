import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CityMap extends StatefulWidget {
  const CityMap({Key? key}) : super(key: key);

  @override
  _CityMapState createState() => _CityMapState();
}

class _CityMapState extends State<CityMap> {
  late GoogleMapController mapController;
  LatLng _userLocation =
      const LatLng(0.0, 0.0); // Initialize with default value
  final double _zoomLevel = 12.0; // Zoom level to focus on the user's location
  Set<Marker> _markers = {}; // Set to hold all the markers
  List<Map<String, dynamic>> _allTutors = []; // List to hold all tutors data
  List<Map<String, dynamic>> _filteredTutors =
      []; // List to hold filtered tutors data
  TextEditingController _searchController = TextEditingController();
  bool _showListTile = false;
  void initState() {
    super.initState();
    _getUserLocation();
    _fetchTutorsFromDocument('primary');
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_showListTile) {
            setState(() {
              _showListTile = false; // Close the ListTile
            });
          }
        },
        child: Stack(
          children: [
            _userLocation.latitude != 0.0
                ? GoogleMap(
                    onMapCreated: (controller) => mapController = controller,
                    initialCameraPosition:
                        CameraPosition(target: _userLocation, zoom: _zoomLevel),
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchTextChanged,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            if (_showListTile && _searchController.text.isNotEmpty)
              Positioned(
                top: 90,
                left: 10,
                right: 10,
                child: Card(
                  elevation: 4,
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: _filteredTutors.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _navigateToMarker(_filteredTutors[index]);
                            setState(() {
                              _showListTile = false; // Close the ListTile
                            });
                          },
                          child: ListTile(
                            title: Text(_filteredTutors[index]['name'] ??
                                'Unknown Tutor'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _fetchTutorsFromDocument(String documentName) {
    FirebaseFirestore.instance
        .collection('levels')
        .doc(documentName)
        .collection('tutors')
        .get()
        .then((snapshot) {
      List<Map<String, dynamic>> tutors = [];
      for (DocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        GeoPoint? location = data['Location'] as GeoPoint?;
        if (location != null) {
          double latitude = location.latitude;
          double longitude = location.longitude;
          LatLng tutorLocation = LatLng(latitude, longitude);
          String tutorName =
              data['name'] ?? 'Unknown Tutor'; // Get the tutor's name
          print(
              'Tutor Name: $tutorName'); // Print the tutor's name for debugging
          _markers.add(
            Marker(
              markerId: MarkerId(doc.id),
              position: tutorLocation,
              infoWindow: InfoWindow(
                  title: tutorName), // Set the tutor's name as the title
            ),
          );
          tutors.add(data);
        }
      }
      setState(() {
        _allTutors = tutors; // Update the list of all tutors
        _filteredTutors = tutors; // Initialize filtered tutors with all tutors
      });
    }).catchError((error) {
      print('Error fetching tutors from $documentName: $error');
    });
  }

  void _onSearchTextChanged(String searchText) {
    setState(() {
      _filteredTutors = _allTutors
          .where((tutor) => (tutor['name'] ?? '')
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
      _showListTile = _filteredTutors.isNotEmpty;
    });
  }

  void _navigateToMarker(Map<String, dynamic> tutor) {
    double latitude = tutor['Location'].latitude;
    double longitude = tutor['Location'].longitude;
    LatLng tutorLocation = LatLng(latitude, longitude);
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(tutorLocation, _zoomLevel));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selected_marker'),
          position: tutorLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue), // Change marker color
          infoWindow: InfoWindow(
            title: tutor['name'] ?? 'Unknown Tutor',
          ),
        ),
      );
    });
  }
}

void main() {
  runApp(const MaterialApp(
    home: CityMap(),
  ));
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TeacherInMap extends StatefulWidget {
  final LatLng teacherLocation; // Location of the teacher
  final String teacherName;

  const TeacherInMap({
    Key? key,
    required this.teacherLocation,
    required this.teacherName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TeacherInMapState();
  }
}

class _TeacherInMapState extends State<TeacherInMap> {
  late GoogleMapController mapController;
  late Set<Marker> _markers;
  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _createMarkers(String teacherName) {
    return <Marker>[
      Marker(
        markerId: MarkerId('TeacherLocation'),
        position: widget.teacherLocation,
        infoWindow: InfoWindow(title: teacherName),
      ),
    ].toSet();
  }

  void _setMarkers() {
    setState(() {
      _markers = _createMarkers(widget.teacherName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: Width * 0.95,
      height: Height * 0.3,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition:
            CameraPosition(target: widget.teacherLocation, zoom: 16),
        markers: _markers,
      ),
    );
  }
}

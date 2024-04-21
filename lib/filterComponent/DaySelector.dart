import 'package:flutter/material.dart';

class DaySelector extends StatefulWidget {
  final ValueChanged<List<String>>?
      onSelectionChanged; // Define the named parameter

  DaySelector({Key? key, this.onSelectionChanged}) : super(key: key);

  @override
  _DaySelectorState createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<bool> isSelected = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select day",
            style: TextStyle(
              fontSize: 22,
              color: Color.fromARGB(255, 61, 60, 60),
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _buildDayButton(i),
                  ),
                for (int i = 4; i < days.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _buildDayButton(i),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDayButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected[index] = !isSelected[index];
          widget.onSelectionChanged
              ?.call(getSelectedDays()); // Notify parent about selection change
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected[index]
                ? Color.fromARGB(255, 25, 162, 183)
                : Color.fromARGB(255, 25, 162, 183),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              isSelected[index]
                  ? const Icon(
                      Icons.done_rounded,
                      color: Color.fromARGB(255, 25, 162, 183),
                    )
                  : Transform.scale(
                      scale: 0.5,
                      child: const Icon(
                        Icons.fiber_manual_record,
                        color: Colors.grey,
                      ),
                    ),
              const SizedBox(width: 5),
              Text(
                days[index],
                style: TextStyle(
                  fontSize: 18,
                  color: isSelected[index]
                      ? Color.fromARGB(255, 25, 162, 183)
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> getSelectedDays() {
    List<String> selectedDays = [];
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) {
        selectedDays.add(days[i]);
      }
    }
    return selectedDays;
  }
}

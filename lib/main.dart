import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;
  int energyLevel = 100;
  String selectedActivity = "Play Time"; // Default activity
  late Timer hungerTimer; // Timer for hunger increase

  @override
  void initState() {
    super.initState();
    hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel = (hungerLevel + 5).clamp(0, 100);
        if (hungerLevel > 80)
          happinessLevel = (happinessLevel - 10).clamp(0, 100);
      });
    });
  }

  @override
  void dispose() {
    hungerTimer.cancel();
    super.dispose();
  }

  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      hungerLevel = (hungerLevel + 5).clamp(0, 100);
      energyLevel = (energyLevel - 15).clamp(0, 100);
    });
  }

  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 20).clamp(0, 100);
      happinessLevel = (happinessLevel + 5).clamp(0, 100);
      energyLevel = (energyLevel + 10).clamp(0, 100);
    });
  }

  void _restPet() {  // Renamed for clarity
    setState(() {
      energyLevel = (energyLevel + 20).clamp(0, 100);
    });
  }


  void _performActivity() {
    if (selectedActivity == "Play Time") {
      _playWithPet();
    } else if (selectedActivity == "Dinner Time") {
      _feedPet();
    } else if (selectedActivity == "Bed Time") {
      _restPet(); // Call the renamed function
    }
  }

  Color _getPetColor() {
    if (happinessLevel > 70) return Colors.green;
    if (happinessLevel >= 30) return Colors.yellow;
    return Colors.red;
  }

  String _getMood() {
    if (happinessLevel > 70) return "Happy 😊";
    if (happinessLevel >= 30) return "Whatever 😐";
    return "Sad 😞";
  }

  String _checkGameState() {
    if (hungerLevel == 100 && happinessLevel <= 10) return "This game is Over! 🥺";
    if (happinessLevel >= 80) return "Yayyyy, You Win! 🎉";
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Digital Pet App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ... (rest of the code is the same, except for the DropdownButton)
            DropdownButton<String>(
              value: selectedActivity,
              items: ["Play Time", "Dinner Time", "Bed Time"]
                  .map((activity) =>
                  DropdownMenuItem(value: activity, child: Text(activity)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedActivity = value!;
                });
              },
            ),
            // ... (rest of the code is the same)
          ],
        ),
      ),
    );
  }
}
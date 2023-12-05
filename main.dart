import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFFFFFFFF),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
      ),
      title: 'BMI Calculator',
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();


}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bmivalueController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  String gender = " ";


  void calculateBMI() {
    // BMI calculation logic goes here
    setState(() {
      double _height = double.parse(heightController.text) / 100;
      double _weight = double.parse(weightController.text);
      double bmi = _weight / (_height * _height);
      bmivalueController.text = bmi.toStringAsFixed(2);

      if (gender == 'Male') {
        if (bmi < 18.5)
          statusController.text = 'Underweight. Careful during strong wind!';
        else if (bmi >= 18.5 && bmi <= 24.9)
          statusController.text = 'That’s ideal! Please maintain';
        else if (bmi >= 25.0 && bmi <= 29.9)
          statusController.text = 'Overweight! Work out please';
        else
          statusController.text = 'Whoa Obese! Dangerous mate!';
      } else if (gender == 'Female') {
        if (bmi < 16)
          statusController.text = 'Underweight. Careful during strong wind!';
        else if (bmi >= 16 && bmi <= 22)
          statusController.text = 'That’s ideal! Please maintain';
        else if (bmi >= 22 && bmi <= 27)
          statusController.text = 'Overweight! Work out please';
        else
          statusController.text = 'Whoa Obese! Dangerous mate!';
      }
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
        ),
        body: SingleChildScrollView (
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: fullnameController,
                    decoration: InputDecoration(
                      labelText: 'Fullname',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: heightController,
                    decoration: InputDecoration(
                      labelText: 'Height in cm',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: 'Weight in KG',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: bmivalueController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Bmi Value',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Male'),
                        leading: Radio(
                          value: 'Male',
                          groupValue: gender,
                          onChanged: (String? value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Female'),
                        leading: Radio(
                          value: 'Female',
                          groupValue: gender,
                          onChanged: (String? value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: calculateBMI,
                  child: Text('Calculate BMI'),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(statusController.text) ,
                )



              ],
            )
        )
    );
  }
}
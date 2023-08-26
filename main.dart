import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart'; // Import the math_expression package


void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = ''; // To store user input
  double _result = 0.0; // To store calculation result

  // Function to handle button presses
  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        // Perform calculation when '=' is pressed
        _result = _calculate();
        _input = _result.toString();
      } else if (buttonText == 'C') {
        // Clear the input
        _input = '';
      } else {
        // Append the button text to the input
        _input += buttonText;
      }
    });
  }

  // Function to perform calculation
  double _calculate() {
    // Parse the input and perform the calculation
    try {
      // Example: "2+3*4" -> 14.0
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval;
    } catch (e) {
      return 0.0; // Return 0 if an error occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _input,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('/'),
              ],
            ),
            // ... Repeat similar rows for other rows of buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton('C'),
                buildButton('0'),
                buildButton('='),
                buildButton('+'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Define a function to create calculator buttons
  Widget buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          _onButtonPressed(text);
        },
        child: Text(text),
      ),
    );
  }
}

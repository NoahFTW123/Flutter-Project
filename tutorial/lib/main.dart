import 'package:flutter/material.dart';

// Entry point of the application
void main() {
  runApp(const MyApp());
}

// Main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noahs App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(), // Sets the home widget of the app
    );
  }
}

// Home page widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// State class for the home page widget
class _MyHomePageState extends State<MyHomePage> {
  String text = ""; // Variable to hold the text entered by the user

  // Function to update the text variable
  void changeText(String newText) {
    setState(() {
      text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello World')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextInputWidget(callback: changeText), // Custom widget to input text
            Text(text), // Displays the text entered by the user
          ],
        ),
      ),
    );
  }
}

// Custom widget for text input
class TextInputWidget extends StatefulWidget {
  final Function(String) callback; // Callback function to pass the text back to the parent

  const TextInputWidget({required this.callback, super.key});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

// State class for the TextInputWidget
class _TextInputWidgetState extends State<TextInputWidget> {
  final TextEditingController controller = TextEditingController(); // Controller for the text field
  final FocusNode focusNode = FocusNode(); // Focus node to manage focus for the text field

  @override
  void dispose() {
    controller.dispose(); // Dispose the controller when the widget is disposed
    focusNode.dispose(); // Dispose the focus node when the widget is disposed
    super.dispose();
  }

  // Function to handle button click and send text to parent widget
  void click() {
    widget.callback(controller.text); // Call the callback with the text
    controller.clear(); // Clear the text field
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.message), // Icon at the beginning of the text field
          labelText: "Type a Message:", // Label for the text field
          suffixIcon: IconButton(
            icon: const Icon(Icons.send), // Icon button to send the text
            splashColor: Colors.blue,
            tooltip: "Post Message",
            onPressed: click, // Call the click function when pressed
          ),
        ),
        onTap: () {
          focusNode.requestFocus(); // Request focus when the text field is tapped
        },
      ),
    );
  }
}

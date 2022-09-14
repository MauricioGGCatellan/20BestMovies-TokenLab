import 'package:flutter/material.dart';

class ErrorSign extends StatefulWidget {
  const ErrorSign({super.key, required this.callback});

  final Function callback;

  @override
  State<ErrorSign> createState() => _ErrorSignState();
}

class _ErrorSignState extends State<ErrorSign> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.error_outline, size: 40),
          Text('Connection error!', style: TextStyle(fontSize: 20.0))
        ],
      ),
      const SizedBox(height: 30),
      ElevatedButton(
          onPressed: () {
            widget.callback();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 161, 185, 162)),
          ),
          child: const Text('Try again', style: TextStyle(color: Colors.black)))
    ]);
  }
}

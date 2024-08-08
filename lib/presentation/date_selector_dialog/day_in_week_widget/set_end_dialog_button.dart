import 'package:flutter/material.dart';

class SetEndDialogButton extends StatelessWidget {
  final bool state;
  final String text;
  final Function(BuildContext  context) callback;

  const SetEndDialogButton({
    super.key,
    required this.state,
    required this.text,
    required this.callback
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: state ? 
            const Color.fromARGB(255, 231, 231, 231) :
              const Color.fromRGBO(118, 253, 172, 1),
          borderRadius: BorderRadius.circular(25)
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
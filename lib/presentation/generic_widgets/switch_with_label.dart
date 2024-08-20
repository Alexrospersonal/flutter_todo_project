import 'package:flutter/material.dart';

class SwitchWithLabel extends StatelessWidget {
  final bool state;
  final String label;
  final Function(bool) callback;

  const SwitchWithLabel(
      {super.key,
      required this.state,
      required this.label,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          // thumbIcon: MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
          //   if (states.contains(MaterialState.disabled)) {
          //     return const Icon(Icons.close);
          //   }
          //   return null; // All other states will use the default thumbIcon.
          // }),
          activeColor: const Color.fromRGBO(118, 253, 172, 1),
          activeTrackColor: const Color.fromARGB(255, 231, 231, 231),
          // trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          //   return Colors.white; // Use the default color.
          // }),
          // trackOutlineWidth: MaterialStateProperty.resolveWith<double?>((Set<MaterialState> states) {
          //   return 2;
          // }),
          // trackColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          //   return Colors.grey[300]!;
          // }),
          value: state,
          onChanged: callback,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(label,
            style: TextStyle(
                fontSize: 18,
                height: 1,
                color: state ? Colors.black : Colors.grey))
      ],
    );
  }
}

import 'package:flutter/material.dart';

class AdditionalSettingInput extends StatefulWidget {
  final String buttonLabel;
  final IconData icon;
  final bool state;
  final void Function(bool state) callback;

  const AdditionalSettingInput(
      {super.key,
      required this.buttonLabel,
      required this.icon,
      required this.state,
      required this.callback});

  @override
  State<AdditionalSettingInput> createState() => _AdditionalSettingInputState();
}

class _AdditionalSettingInputState extends State<AdditionalSettingInput> {
  @override
  Widget build(BuildContext context) {
    var offTextStyle = Theme.of(context)
        .textTheme
        .labelMedium!
        .copyWith(fontWeight: FontWeight.normal);
    var onTextStyle = Theme.of(context).textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.onSurface);

    Color iconColor = widget.state ? onTextStyle.color! : offTextStyle.color!;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
              height: 32,
              child: ElevatedButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 10))),
                onPressed: () => widget.callback(true),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.buttonLabel,
                        style: widget.state ? onTextStyle : offTextStyle),
                    Icon(
                      widget.icon,
                      color: iconColor,
                    )
                  ],
                ),
              )),
        ),
        const SizedBox(
          width: 16,
        ),
        Switch(
          value: widget.state,
          onChanged: (value) {
            widget.callback(value);
          },
        )
      ],
    );
  }
}

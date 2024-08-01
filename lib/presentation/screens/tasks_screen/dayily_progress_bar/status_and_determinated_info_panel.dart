import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';

class StatusAndDeterminatedInfoPanel extends StatelessWidget {
  const StatusAndDeterminatedInfoPanel({
    super.key,
    required this.determinatedTasks,
  });

  final int determinatedTasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "😎",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).yourStatus,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    S.of(context).statusTitle1,
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: S.of(context).determinatedTasks,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: "$determinatedTasks",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

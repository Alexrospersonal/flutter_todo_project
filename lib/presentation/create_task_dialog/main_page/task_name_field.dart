import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/task_dialog_expanded_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class TaskNameField extends ConsumerWidget {
  final TextEditingController titleController;
  final String invalidValidationText;
  final GlobalKey<FormState> formKey;

  const TaskNameField(
      {super.key,
      required this.titleController,
      required this.invalidValidationText,
      required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return invalidValidationText;
          }
          return null;
        },
        onTap: () {
          ref.read(initialTaskDialogExpandedProvider.notifier).state = false;
        },
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        controller: titleController,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface),
        decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).canvasColor,
            contentPadding: const EdgeInsets.all(10),
            hintText: S.of(context).addTaskName,
            hintStyle: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontWeight: FontWeight.w400),
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(smallBorderRadius),
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(smallBorderRadius),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(smallBorderRadius),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error, width: 2.0),
            ),
            errorStyle: const TextStyle(fontSize: 0, height: 1)
            // errorStyle: const TextStyle(fontSize: 0)
            ),
        onChanged: (value) {
          // Перевіряємо форму, коли змінюється значення
          if (formKey.currentState?.validate() ?? false) {
            // Скидаємо помилку
            // formKey.currentState?.reset();
            formKey.currentState?.validate();
          }
        },
        autofocus: false,
      ),
    );
  }
}

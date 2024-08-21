import 'package:flutter/material.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_task_settings.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/category/category_selector_widget.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/icon_buttons_row.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/main_page/task_description_field.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/main_page/task_name_field.dart';

class TaskDialogMainPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final void Function(bool) callback;
  final void Function(int) onItemTapped;
  final double topPadding;

  const TaskDialogMainPage(
      {super.key,
      required this.formKey,
      required this.titleController,
      required this.descriptionController,
      required this.onItemTapped,
      required this.callback,
      this.topPadding = 0});

  @override
  State<TaskDialogMainPage> createState() => _TaskDialogMainPageState();
}

class _TaskDialogMainPageState extends State<TaskDialogMainPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, widget.topPadding, 0, 0),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                child: Column(
                  children: [
                    TaskNameField(
                      titleController: widget.titleController,
                      invalidValidationText: S.of(context).addTaskName,
                      formKey: widget.formKey,
                    ),
                    TaskDescriptionField(
                      descriptionController: widget.descriptionController,
                      callback: widget.callback,
                    ),
                    const CategorySelectorWidget(),
                    const IconButtonsRow(),
                    AdditionalTaskSetting(onItemTapped: widget.onItemTapped),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

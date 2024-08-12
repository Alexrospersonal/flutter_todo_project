import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/additional_settings/additional_task_settings.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/category/category_selector_widget.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/icon_buttons_row.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/main_page/task_name_field.dart';

class TaskDialogMainPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final double topPadding;

  const TaskDialogMainPage(
      {super.key,
      required this.formKey,
      required this.titleController,
      this.topPadding = 0});

  @override
  State<TaskDialogMainPage> createState() => _TaskDialogMainPageState();
}

class _TaskDialogMainPageState extends State<TaskDialogMainPage> {
  // final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    // _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
                    // TODO: замінити на текстовий редактор
                    // TaskDescriptionField(
                    //     descriptionController: _descriptionController),
                    const TaskNotateEditField(),
                    const CategorySelectorWidget(),
                    const IconButtonsRow(),
                    const AdditionalTaskSetting(),
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

// TODO: Подумати як вмонтувати цей текстовий редактор в діалогове вікно
class TaskNotateEditField extends StatefulWidget {
  const TaskNotateEditField({super.key});

  @override
  State<TaskNotateEditField> createState() => _TaskNotateEditFieldState();
}

class _TaskNotateEditFieldState extends State<TaskNotateEditField> {
  QuillController controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuillToolbar.simple(
          controller: controller,
          configurations: const QuillSimpleToolbarConfigurations(
              showBackgroundColorButton: true,
              sectionDividerSpace: 0,
              buttonOptions: QuillSimpleToolbarButtonOptions(
                  base: QuillToolbarBaseButtonOptions(
                iconSize: 14,
                iconButtonFactor: 1,
              ))),
        ),
        Container(
          color: Theme.of(context).canvasColor,
          child: Expanded(
            child: QuillEditor.basic(
              controller: controller,
              configurations: const QuillEditorConfigurations(),
            ),
          ),
        )
      ],
    );
  }
}

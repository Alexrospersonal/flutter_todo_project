import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/task_dialog_expanded_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class TaskDescriptionField extends ConsumerStatefulWidget {
  final void Function(bool) callback;

  const TaskDescriptionField({
    super.key,
    required TextEditingController descriptionController,
    required this.callback,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  ConsumerState<TaskDescriptionField> createState() =>
      _TaskDescriptionFieldState();
}

class _TaskDescriptionFieldState extends ConsumerState<TaskDescriptionField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      widget.callback(false);
      FocusScope.of(context).unfocus();
    } else {
      widget.callback(true);
    }

    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface),
        controller: widget._descriptionController,
        focusNode: _focusNode,
        autofocus: false,
        maxLines: _isFocused ? 5 : 1,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        onTap: () {
          ref.read(initialTaskDialogExpandedProvider.notifier).state = false;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).canvasColor,
          hintText: S.of(context).notes,
          hintStyle: const TextStyle(color: greyColor),
          isDense: true,
          contentPadding: const EdgeInsets.all(10),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(smallBorderRadius),
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(smallBorderRadius),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
          ),
        ),
      ),
    );
  }
}

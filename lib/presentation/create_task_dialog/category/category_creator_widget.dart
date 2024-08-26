import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/build_task_notifiers/task_notifier.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';
import 'package:flutter_todo_project/domain/utils/smiles_data.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/category/category_emoji_selector.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/category/emoji_switch_category_button.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/main_page/task_name_field.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/task_form_title.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';
import 'package:provider/provider.dart';

class CategoryCreatorWidget extends ConsumerStatefulWidget {
  final BuildContext context;

  const CategoryCreatorWidget({super.key, required this.context});

  @override
  ConsumerState<CategoryCreatorWidget> createState() =>
      _CategoryCreatorWidgetState();
}

class _CategoryCreatorWidgetState extends ConsumerState<CategoryCreatorWidget> {
  final categoryNameController = TextEditingController();
  final emojiController = TextEditingController();
  var selectedEmojisListIdx = 0;

  final _formKey = GlobalKey<FormState>();

  bool addNewCategory() {
    if (_formKey.currentState!.validate()) {
      String categoryName = emojiController.text + categoryNameController.text;

      var newCategory = ref
          .read(listCategoryNotifierProvider.notifier)
          .addCategory(categoryName);
      widget.context.read<TaskNotifier>().setCategory(newCategory);

      categoryNameController.clear();

      return true;
    }
    return false;
  }

  void addEmoji(String emoji) {
    setState(() {
      emojiController.clear();
      emojiController.text = emoji;
    });
  }

  void setSelectedEmojisListIdx(int idx) {
    setState(() {
      selectedEmojisListIdx = idx;
    });
  }

  List<String> getEmojis() {
    return emojisCategoryList[selectedEmojisListIdx];
  }

  @override
  void dispose() {
    super.dispose();
    categoryNameController.dispose();
    emojiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmojiSelected = emojiController.text.isNotEmpty;
    List<String> faceEmojis = getEmojis();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(bigBorderRadius)),
          backgroundColor: Theme.of(context).cardColor,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: SizedBox(
            height: 445,
            child: Stack(clipBehavior: Clip.none, children: [
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskFormTitleWidget(title: S.of(context).createTask),
                      const Divider(color: greyColor),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 27),
                        child: Row(children: [
                          if (isEmojiSelected)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Text(
                                emojiController.text,
                                style: const TextStyle(fontSize: 21),
                              ),
                            ),
                          Expanded(
                            child: TaskNameField(
                              titleController: categoryNameController,
                              invalidValidationText: "Enter a category name",
                              formKey: _formKey,
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 27, vertical: 10),
                        child: SizedBox(
                          height: 45,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  EmojiSwicthCategoryButton(
                                    index: index,
                                    selectedIndex: selectedEmojisListIdx,
                                    callback: setSelectedEmojisListIdx,
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 10),
                              itemCount: emojiCategory.length),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 27),
                        child: EmojiSelector(
                          callback: addEmoji,
                          emojis: faceEmojis,
                        ),
                      ),
                    ]),
              ),
              Positioned(
                  left: 100,
                  right: 100,
                  bottom: -8,
                  child: DoneButton(action: () => addNewCategory()))
            ]),
          )),
    );
  }
}

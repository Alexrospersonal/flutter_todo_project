import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/dialog/dialog_done_button.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/task/task_form.dart';

class CategoryCreatorWidget extends StatelessWidget {
  const CategoryCreatorWidget(
      {
        super.key,
        required this.categoryNameController,
        required this.addNewCategory  
      }
    );

  final TextEditingController categoryNameController;
  final Function addNewCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          Stack(
            clipBehavior: Clip.none,
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TaskFormTitleWidget(title: "створити список",),
                      const SizedBox(height: 20),
                      TaskNameField(titleController: categoryNameController),
                      const SizedBox(height: 20),
                      Text(
                        "додати іконку".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat'
                        ),
                      ),
                      const SizedBox(height: 5),
                      EmojiSelector(categoryNameController: categoryNameController),
                      const SizedBox(height: 20)
                    ]
                  )
              ),
              Positioned(
                left: 155-30,
                right: 155-30,
                bottom: -25,
                child: DoneButton(action: addNewCategory)
              )
            ]
          )
        ]
      ),
    );
  }
}

class EmojiSelector extends StatefulWidget {
  final TextEditingController categoryNameController;

  const EmojiSelector({super.key, required this.categoryNameController});

  @override
  State<EmojiSelector> createState() => _EmojiSelectorState();
}

class _EmojiSelectorState extends State<EmojiSelector> {

  int _selectedEmojiIndex = -1;

  final List<String> _emojis = [
    "😊", "😄", "😍", "😂", "🥰", "😎", "🤩", "😇",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 228, 228),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Wrap(
        spacing: 10,
        children: _emojis.asMap().entries.map((e) {
          final int index = e.key;
          final String emoji = e.value;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedEmojiIndex = _selectedEmojiIndex == index ? -1 : index;
                String selectedText = widget.categoryNameController.text;
                String newText = _emojis[_selectedEmojiIndex] + selectedText;
                widget.categoryNameController.text = newText;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedEmojiIndex == index ? Colors.blue : Colors.transparent,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

}
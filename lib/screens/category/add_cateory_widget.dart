import 'package:flutter/material.dart';

class AddCategoryDialogWidget extends StatelessWidget {
  const AddCategoryDialogWidget(
      {super.key,
      required TextEditingController newCategoryTextField,
      required this.addNewCategory})
      : _newCategoryTextField = newCategoryTextField;

  final TextEditingController _newCategoryTextField;
  final Function addNewCategory;

  @override
  Widget build(BuildContext context) {


    return SimpleDialog(
      title: const Text("Додати нову категорію"),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(children: [
            TextField(
              controller: _newCategoryTextField,
              decoration: const InputDecoration(hintText: 'Назва категорії'),
            ),
            const SizedBox(height: 20),
            BottomButtonsWidget(addNewCategory: addNewCategory)
            ]
          )
        )
      ]
    );
  }
}

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({
    super.key,
    required this.addNewCategory,
  });

  final Function addNewCategory;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")),
        const SizedBox(width: 10),
        ElevatedButton(
            onPressed: () {
              addNewCategory();
              Navigator.of(context).pop();
            },
            child: const Text("Add"))
      ],
    );
  }
}

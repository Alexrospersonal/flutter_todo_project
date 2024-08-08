import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class CategoryList extends ConsumerStatefulWidget {
  const CategoryList({super.key});

  @override
  ConsumerState<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryList> {
  // int _selectedIndex = 0;
  final emojiRegex = RegExp(r'^\p{Emoji}', unicode: true);

  bool checkIfEmojiExists(String text) {
    return emojiRegex.hasMatch(text);
  }

  String getEmoji(String text) {
    return text.substring(0,2);
  }

  String getTextWithoutEmoji(String text) {
    return text.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = ref.watch(selectedCategoryIndex);
    var listOfCategories = ref.watch(listCategoryNotifierProvider.notifier).getCategories();
    String tasksName = S.of(context).tasks;
    String today = S.of(context).today;

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: listOfCategories.length + 1,
      separatorBuilder: (context, index) => const SizedBox(width: 16),
      itemBuilder: (context, index) {
        bool isSelected = selectedIndex == index;
        String categoryText = index < listOfCategories.length ? "${listOfCategories[index]}": "";
        String emoji = "";

        if (checkIfEmojiExists(categoryText)) {
          emoji = getEmoji(categoryText);
          categoryText = getTextWithoutEmoji(categoryText);
        }
        if (index == 0) {
          categoryText = today;
        }

        if (index < listOfCategories.length) {
          return GestureDetector(
            onTap: () {
              setState(() {
                // _selectedIndex = index;
                var selectedCategory = ref.read(listCategoryNotifierProvider.notifier).getCategoryById(index);
                ref.read(selectedCategoryNotifierProvider.notifier).selectCategory(selectedCategory);
              });
            },
            child: CategoryListItemContainer(
              isSelected: isSelected,
              categoryText: categoryText,
              emoji: emoji,
              tasksName: tasksName
            ),
          );
        }
        return const CreateCategoryButton();
      },
    );
  }
}

class CreateCategoryButton extends StatelessWidget {
  const CreateCategoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 113,
          maxWidth: 125
        ),
        padding: const EdgeInsets.all(1),
        child: DottedBorder(
          borderType: BorderType.RRect,
          strokeWidth: 2,
          color: greyColor,
          radius: const Radius.circular(bigBorderRadius),
          dashPattern: const [8,8],
          child: const Center(child: Icon(
            Icons.add,
            color: greyColor,
            )
          )
        )
      ),
    );
  }
}

class CategoryListItemContainer extends StatelessWidget {
  const CategoryListItemContainer({
    super.key,
    required this.isSelected,
    required this.categoryText,
    required this.emoji,
    required this.tasksName,
  });

  final bool isSelected;
  final String categoryText;
  final String emoji;
  final String tasksName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(bigBorderRadius),
          color:
              isSelected ? primaryColor : Theme.of(context).cardColor
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 0,
              child: Text(
                categoryText.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 1,
                  color: isSelected ? Theme.of(context).canvasColor : textColor
                ),
              ),
            ),
            Positioned(
              bottom: 13,
              child: Text(
                emoji,
                style:const TextStyle(
                  fontSize: 75,
                  height: 1
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Icon(
                Icons.error_outline_outlined,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "99 $tasksName",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}

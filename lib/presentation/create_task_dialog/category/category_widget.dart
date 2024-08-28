import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_project/domain/state/list_state.dart';
import 'package:flutter_todo_project/generated/l10n.dart';
import 'package:flutter_todo_project/presentation/create_task_dialog/category/category_creator_widget.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class CategoryList extends ConsumerStatefulWidget {
  const CategoryList({super.key});

  @override
  ConsumerState<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryList> {
  final emojiRegex = RegExp(r'^\p{Emoji}', unicode: true);
  int selectedIndex = 0;

  bool checkIfEmojiExists(String text) {
    return emojiRegex.hasMatch(text);
  }

  String getEmoji(String text) {
    return text.substring(0, 2);
  }

  String getTextWithoutEmoji(String text) {
    return text.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    var listOfCategories = ref.watch(categoriesProvider);

    String today = S.of(context).today;

    return listOfCategories.when(
        data: (list) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: list.length + 1,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              if (index == list.length) {
                return const CreateCategoryButton();
              }

              bool isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  ref.read(selectedCategoryId.notifier).state =
                      list[index].categoryId;

                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: CategoryListItemContainer(
                    isSelected: isSelected,
                    categoryText:
                        list[index].name == "#01" ? today : list[index].name,
                    emoji: list[index].emoji,
                    tasksCount: list[index].tasks),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Scaffold(
              body: Center(
            child: Text('Error: $error'),
          ));
        },
        loading: () => const Center(child: CircularProgressIndicator()));
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
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.white.withOpacity(0),
          builder: (BuildContext context) {
            return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: CategoryCreatorWidget(
                    context: context, getCreatedCategoryId: (p0) {}));
          },
        );
      },
      child: Container(
          constraints: const BoxConstraints(minWidth: 113, maxWidth: 125),
          padding: const EdgeInsets.all(1),
          child: DottedBorder(
              borderType: BorderType.RRect,
              strokeWidth: 2,
              color: greyColor,
              radius: const Radius.circular(bigBorderRadius),
              dashPattern: const [8, 8],
              child: const Center(
                  child: Icon(
                Icons.add,
                color: greyColor,
              )))),
    );
  }
}

class CategoryListItemContainer extends StatelessWidget {
  const CategoryListItemContainer({
    super.key,
    required this.isSelected,
    required this.categoryText,
    required this.emoji,
    required this.tasksCount,
  });

  final bool isSelected;
  final String categoryText;
  final String emoji;
  final int tasksCount;

  @override
  Widget build(BuildContext context) {
    String tasksName = S.of(context).tasks;

    return Container(
      width: 125,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(bigBorderRadius),
          color: isSelected ? primaryColor : Theme.of(context).cardColor),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Stack(alignment: Alignment.topCenter, children: [
          Positioned(
            left: 0,
            child: Text(
              categoryText.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 1,
                  color:
                      isSelected ? Theme.of(context).canvasColor : textColor),
            ),
          ),
          Positioned(
            bottom: 13,
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 75, height: 1),
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
                "$tasksCount $tasksName",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_todo_project/presentation/styles/theme_styles.dart';

class EmojiSelector extends StatefulWidget {
  final List<String> emojis;
  final void Function(String) callback;

  const EmojiSelector(
      {super.key, required this.emojis, required this.callback});

  @override
  State<EmojiSelector> createState() => _EmojiSelectorState();
}

class _EmojiSelectorState extends State<EmojiSelector> {
  int _selectedEmojiIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(mediumBorderRadius),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 5.0, // Горизонтальний відступ між елементами
          mainAxisSpacing: 5.0,
          maxCrossAxisExtent: 50, // Вертикальний відступ між елементами
        ),
        itemCount: widget.emojis.length,
        itemBuilder: (context, index) {
          final String emoji = widget.emojis[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedEmojiIndex = _selectedEmojiIndex == index ? -1 : index;
                String emoji = _selectedEmojiIndex >= 0
                    ? widget.emojis[_selectedEmojiIndex]
                    : "";
                widget.callback(emoji);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedEmojiIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

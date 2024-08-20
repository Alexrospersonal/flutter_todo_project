import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_project/domain/utils/generic.dart';
import 'package:flutter_todo_project/presentation/generic_widgets/nested_time_picker/nested_time_picker_input.dart';

void main() {
  testWidgets('Test NestedTimePickerInput', (WidgetTester tester) async {
    int? time;
    TimePickerInputType? type2;

    void testFunc(int value, TimePickerInputType type) {
      time = value;
      type2 = type;
    }

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            height: 100,
            child: Column(
              children: [
                NestedTimePickerInput(
                  flex: 1,
                  inputType: TimePickerInputType.hour,
                  initialTime: 21,
                  callback: testFunc,
                  enabled: true,
                ),
              ],
            ),
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    final textField = find.text("21");

    expect(textField, findsOneWidget);

    await tester.enterText(textField, '12');
    await tester.pump();

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(time, 12);
    expect(type2, TimePickerInputType.hour);
  });
}

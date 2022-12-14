import 'package:app_personal_expenses/components/graphic_bar.dart';
import 'package:app_personal_expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Graphic extends StatelessWidget {
  final List<Expense> recentExpenses;

  Graphic({required this.recentExpenses});

  Map<String, String> weekDaysMapped = {
    'Mon': 'Seg',
    'Tue': 'Ter',
    'Wed': 'Qua',
    'Thu': 'Qui',
    'Fri': 'Sex',
    'Sat': 'Sab',
    'Sun': 'Dom',
  };

  List<Map<String, Object>> get groupedExpenses {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double valueTotal = 0.0;

      for (var i = 0; i < recentExpenses.length; i++) {
        bool sameDay = recentExpenses[i].date.day == weekDay.day;
        bool sameMonth = recentExpenses[i].date.month == weekDay.month;
        bool sameYear = recentExpenses[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          valueTotal += recentExpenses[i].value;
        }
      }

      return {
        'day': weekDaysMapped[DateFormat('EEE').format(weekDay)].toString(),
        'value': valueTotal,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedExpenses.fold(0.0, (previousValue, element) {
      return previousValue + (element['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedExpenses.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: GraphicBar(
                label: e['day'].toString(),
                value: e['value'] as double,
                percentage: _weekTotalValue == 0 ? 0 : (e['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );

  }
}

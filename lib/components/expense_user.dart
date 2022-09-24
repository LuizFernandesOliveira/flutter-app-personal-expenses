import 'dart:math';

import 'package:app_personal_expenses/components/expense_form.dart';
import 'package:app_personal_expenses/components/expense_list.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';


class ExpenseUser extends StatefulWidget {

  @override
  State<ExpenseUser> createState() => _ExpenseUserState();
}

class _ExpenseUserState extends State<ExpenseUser> {
  final _expenses = [
    Expense(id: 'e1', title: 'novo celular', value: 2000, date: DateTime.now()),
    Expense(id: 'e2', title: 'conta de luz', value: 200, date: DateTime.now()),
  ];

  _addExpense(String title, double value) {
    final newExpense = Expense(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now()
    );
    setState(() {
      _expenses.add(newExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpenseList(expenses: _expenses),
        ExpenseForm(onSubmit: _addExpense),
      ],
    );
  }
}

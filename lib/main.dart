import 'dart:math';

import 'package:app_personal_expenses/components/expense_form.dart';
import 'package:app_personal_expenses/components/graphic.dart';
import 'package:flutter/material.dart';
import 'components/expense_list.dart';
import 'models/expense.dart';

void main() => runApp(PersonalExpensesApp());

class PersonalExpensesApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        )
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Expense> _expenses = [
    Expense(id: 'e1', title: 'novo celular', value: 2000, date: DateTime.now()),
    Expense(id: 'e2', title: 'conta de luz', value: 200, date: DateTime.now().subtract(Duration(days: 1))),
  ];

  List<Expense> get _recentExpenses {
    return _expenses.where((e) {
      return e.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

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
    Navigator.of(context).pop();
  }

  _openExpenseFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ExpenseForm(onSubmit: _addExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          IconButton(
            onPressed: () => _openExpenseFormModal(context),
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Graphic(recentExpenses: _recentExpenses),
            ExpenseList(expenses: _expenses),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openExpenseFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

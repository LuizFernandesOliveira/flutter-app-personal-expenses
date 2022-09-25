import 'dart:math';

import 'package:app_personal_expenses/components/form.dart';
import 'package:app_personal_expenses/components/graphic.dart';
import 'package:flutter/material.dart';
import 'components/list.dart';
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
    Expense(id: 't1', title: 'produto 1', value: 2000, date: DateTime.now().subtract(Duration(days: 6))),
    Expense(id: 't2', title: 'produto 2', value: 1000, date: DateTime.now().subtract(Duration(days: 5))),
    Expense(id: 't3', title: 'produto 3', value: 1000, date: DateTime.now()),
  ];

  List<Expense> get _recentExpenses {
    return _expenses.where((e) {
      return e.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addExpense(String title, double value, DateTime date) {
    final newExpense = Expense(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date,
    );
    setState(() {
      _expenses.add(newExpense);
    });
    Navigator.of(context).pop();
  }

  _deleteExpense(String id) {
    setState(() {
      _expenses.removeWhere((element) => element.id == id);
    });
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
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Graphic(recentExpenses: _recentExpenses),
            ExpenseList(expenses: _expenses, onDelete: _deleteExpense),
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

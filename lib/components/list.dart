import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(String) onDelete;

  ExpenseList({required this.expenses, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    height: constraints.maxHeight * 0.1,
                    child: const Text(
                      'Nenhuma Despesa Cadastrada',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    width: constraints.maxHeight * 0.8,
                    child: Image.asset(
                      'assets/images/zzz.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (ctx, index) {
              final expense = expenses[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                            'R\$${NumberFormat("#,##0.00", "pt_BR").format(expense.value)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    expense.title,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(expense.date),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () => onDelete(expense.id),
                  ),
                ),
              );
            },
          );
  }
}

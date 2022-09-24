import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(String) onDelete;

  ExpenseList({required this.expenses, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: expenses.isEmpty
        ? Column(
          children: [
            const Text(
              'Nenhuma Despesa Cadastrada',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 200,
              child: Image.asset(
                'assets/images/zzz.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        )
        : ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (ctx, index) {
            final expense = expenses[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                        child: Text('R\$${expense.value}'),
                    ),
                  ),
                ),
                title: Text(
                  expense.title,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  DateFormat('d MMM y').format(expense.date),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () => onDelete(expense.id),
                ),
              ),
            );
          },
      ),
    );
  }
}

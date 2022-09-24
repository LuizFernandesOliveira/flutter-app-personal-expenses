import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  ExpenseList({required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'R\$ ${expense.value.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('d MMM y').format(expense.date),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
      ),
    );
  }
}

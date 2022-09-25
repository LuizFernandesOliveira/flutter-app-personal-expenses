import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  ExpenseForm({required this.onSubmit});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _selectDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(labelText: 'Titulo:'),
              ),
              TextField(
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(labelText: 'Valor (R\$):'),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectDate == null
                          ? 'Nenhuma data selecionada!'
                          : DateFormat('dd/MM/y').format(_selectDate)),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: const Text(
                        'Selecionar data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Nova Despesa'),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

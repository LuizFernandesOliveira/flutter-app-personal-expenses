import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraphicBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  GraphicBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          margin: EdgeInsets.symmetric(horizontal: 3),
          child: FittedBox(
            child: Text(NumberFormat("#,##0.00", "pt_BR").format(value)),
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 80,
          width: 30,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}

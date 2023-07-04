// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoneyBox extends StatelessWidget {
  String title;
  double amount;
  Color color;
  double size;

  MoneyBox(this.title, this.amount, this.color, this.size);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        height: size,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Expanded(
              child: Text(
                "${NumberFormat('#,###.##').format(amount)}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}

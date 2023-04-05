
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((item) {
        return Card(
          child: Row(
            children: [
              Text('hi')
            ],
          ),
        );
      }).toList(),
    );
  }
}

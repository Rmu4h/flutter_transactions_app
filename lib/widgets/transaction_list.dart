import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_transactions_app/widgets/transaction_item.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    const Text(
                      'No transactions added yet!',
                      // style: Theme.of(context).textTheme.title,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        )),
                  ],
                );
              })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
              },
            ),
    );
  }
}



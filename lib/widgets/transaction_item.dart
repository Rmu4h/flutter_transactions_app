

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key); // кожен віджет в флатері може мати key


  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('${widget.transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ?
        TextButton.icon(
          onPressed: () => widget.deleteTx(widget.transaction.id,),
          icon: const Icon(Icons.delete, color: Colors.red),
          label: const Text('Delete'),
        )
            : IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: () => widget.deleteTx(widget.transaction.id),
        ),
      ),
    );
  }
}
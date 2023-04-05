import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Abount'),
                controller: amountController,
              ),
              TextButton(
                child: const Text(
                    'Add Transaction',
                    style: TextStyle(
                        color: Colors.purple
                    )),
                onPressed: () {
                  addTransaction(titleController.text, amountController.text);
                })
            ],
          ),
        ));
  }
}

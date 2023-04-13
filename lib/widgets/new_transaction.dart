import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty){
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(
        enteredTitle,
        enteredAmount,
        _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              right: 10,
              top: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Text(
                          _selectedDate == null
                              ? 'No date Chosen!'
                              : 'Picked Date : ${DateFormat.yMd().format(_selectedDate!)}'
                      ),
                      TextButton(
                          onPressed: _presentDatePicker,
                          child: const Text(
                            'Choose Date!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: submitData,
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.purple),
                  ),
                  child: const Text('Add Transaction',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          )),
    );
  }
}

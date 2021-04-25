import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop(); // removes the top layer from display
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
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
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 8.0,
              right: 8.0,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Title"),
                  controller: _titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Amount"),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'No data chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'choose date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _presentDatePicker,
                      )
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: submitData,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).textTheme.button.color,
                )
              ],
            ),
          )),
    );
  }
}

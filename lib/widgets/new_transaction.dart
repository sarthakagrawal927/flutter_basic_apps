import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                autocorrect: true,
                autofocus: true,
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
              ),
              TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
              ),
              FlatButton(
                onPressed: () {
                  addTx(titleController.text,
                      double.parse(amountController.text));
                },
                child: Text('Add Transaction'),
                textColor: Colors.purple,
              )
            ],
          ),
        ));
  }
}

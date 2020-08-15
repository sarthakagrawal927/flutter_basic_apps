import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: ListView.builder(
          //ListView = Column + SingleChildScrollView
          itemBuilder: (ctx, index) {
            return Card(
                child: Row(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2)),
                  child: Text(
                    '${transactions[index].amount.toStringAsFixed(2)} Rs',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        fontSize: 20),
                  )),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      DateFormat.yMMMMd()
                          .add_jm()
                          .format(transactions[index].date),
                      style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                    )
                  ])
            ]));
          },
          itemCount: transactions.length,
        ));
  }
}

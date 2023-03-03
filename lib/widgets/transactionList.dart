import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'No Transactions are Added Yet!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  './assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: Text('${transactions[index].amount} ₹'),
                      ),
                    ),
                  ),
                  title: Text(transactions[index].title,
                      style: Theme.of(context).textTheme.titleMedium),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteTransaction(transactions[index].id),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}




                // // Card(
                //   child: Row(
                //     children: [
                //       Container(
                //         margin:
                //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             width: 2,
                //             color: Theme.of(context).primaryColorDark,
                //             style: BorderStyle.solid,
                //           ),
                //           borderRadius: BorderRadius.all(
                //             Radius.circular(4),
                //           ),
                //         ),
                //         padding: EdgeInsets.all(10),
                //         child: Text(
                //           transactions[index].amount.toStringAsFixed(2) + ' ₹',
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 15,
                //               color: Theme.of(context).colorScheme.secondary),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transactions[index].title,
                //             style: TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           Text(
                //             DateFormat.yMMMMd()
                //                 .format(transactions[index].date),
                //             style: TextStyle(fontSize: 10, color: Colors.grey),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );
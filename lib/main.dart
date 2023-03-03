import 'dart:io';

import 'package:flutter/services.dart';

import './widgets/chart.dart';

import './widgets/newTransaction.dart';
import './widgets/transactionList.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        // primaryColor: Colors.teal,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
            titleTextStyle: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold),
            backgroundColor: Colors.teal),
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  bool _showChart = false;
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 'e1',
    //   title: 'New Addidas Shoes',
    //   // name: 'Adarsh',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'e2',
    //   title: 'Bottle of Vine',
    //   // name: 'Arjun',
    //   amount: 200,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  // var inputTitle;
  void _startTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        Platform.isAndroid
            ? Container()
            : IconButton(
                onPressed: () => _startTransaction(context),
                icon: Icon(Icons.add),
              )
      ],
    );

    final txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.6,
      child: TransactionList(_userTransaction, _deleteTransaction),
    );
    // final weekChart = Container(
    //   height: (MediaQuery.of(context).size.height -
    //           appBar.preferredSize.height -
    //           MediaQuery.of(context).padding.top) *
    //       0.7,
    //   child: Chart(_recentTransactions),
    // );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show Chart'),
                    Switch.adaptive(
                      activeColor: Theme.of(context).primaryColor,
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      },
                    ),
                  ],
                ),
              if (!isLandscape)
                Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.4,
                  child: Chart(_recentTransactions),
                ),
              if (!isLandscape) txList,
              if (isLandscape)
                _showChart
                    ? Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        child: Chart(_recentTransactions),
                      )
                    : txList,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => _startTransaction(context),
              child: Icon(Icons.add),
            ),
    );
  }
}

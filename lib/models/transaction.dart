import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  // final String name;
  final double amount;
  final DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      // required this.name,
      required this.amount,
      required this.date});
}

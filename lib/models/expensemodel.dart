import 'package:uuid/uuid.dart';
const uuid = Uuid();

class ExpenseModel{
  ExpenseModel({required this.title, required this.date, required this.amount }): id = uuid.v4();
  final String id;
  final String title;
  final DateTime date;
  final double amount;
}
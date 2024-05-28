import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// date will be formatted as Year Month Day using ymd
final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category {food, travel, leisure, work, misc}

const categoryIcons = {
  Category.food:Icons.lunch_dining_rounded,
  Category.travel:Icons.flight_takeoff_rounded,
  Category.leisure:Icons.movie_rounded,
  Category.work:Icons.work,
  Category.misc:Icons.miscellaneous_services
};

class ExpenseModel{
  ExpenseModel({required this.title, required this.date, required this.amount, required this.category }): id = uuid.v4();
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Category category;

  // getter are "computed properties" => properties that are dynamically derived based on other class properties
  String get formattedDate{
    return formatter.format(date);
  }
}
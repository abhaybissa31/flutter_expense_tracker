import 'package:expense_tracker/models/expensemodel.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/widgets.dart';

class ExpensesList extends StatelessWidget{
  
  const ExpensesList({super.key, required this.expenses});
  final List<ExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    // if we dont know the length and might have light of items, don't use column, use list view. It creates item only when item in list is visible
    // itemCount calls function inside itemBuilder as many time as itemCount's value
    return ListView.builder(itemCount: expenses.length,itemBuilder: (ctx, index)=>ExpenseItem(expenses[index]));
  }
}
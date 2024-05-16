import 'package:expense_tracker/models/expensemodel.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 4),
            // toStringAsfixed ensure roundoff upto to 2 decimal places
            Row(
              children: [
                Text('Rs.${expense.amount.toStringAsFixed(2)}'),
                // spacer takes all the remaining space between first and 2nd widget
                const Spacer(),
                Row(children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 8),
                  // formattedDate is a getter so no need for brackets ()
                  Text(expense.formattedDate)
                ],)
              ],
            )
          ],
        ),
      ),
    );
  }
}

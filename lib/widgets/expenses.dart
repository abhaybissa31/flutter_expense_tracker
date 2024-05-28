import 'package:expense_tracker/models/expensemodel.dart';
import 'package:expense_tracker/widgets/add_expense_modal.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  final List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
      title: 'Flutter Course', 
      amount: 399, 
      date: DateTime.now(), 
      category: Category.work
    ),
    ExpenseModel(
      title: 'VR Mall', 
      amount: 299, 
      date: DateTime.now(), 
      category: Category.leisure
    ),
  ];

  void _addExpense(ExpenseModel expense){
    setState(() {
       _registeredExpenses.add(expense);
    });
  }

  void _modalOpen(){
    // context have widget metadata information related to widget and widget's ui position
    // builder returns a function. here ctx is a context of the bottomModal
    showModalBottomSheet(context: context, builder: (ctx)=> NewExpense(onAddExpense: _addExpense,),isScrollControlled: true);
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abhay Expense Tracker"),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            // using function without () means we are not executing it we are just passing walue when pressed
            onPressed: _modalOpen,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text("The Chart"),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}

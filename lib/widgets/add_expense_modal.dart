import 'package:expense_tracker/models/expensemodel.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// date will be formatted as Year Month Day using ymd
final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpenseModel expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _validateSubmit() {
    final enteredAmount = double.tryParse(_amountInput.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleInput.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                icon: const Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    Text(
                      "Invalid input",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                content: const Text("Please make sure to enter valid details"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("okay"))
                ],
              ));
      return;
    }
    widget.onAddExpense(ExpenseModel(
        title: _titleInput.text,
        date: _selectedDate!,
        amount: enteredAmount,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleInput.dispose();
    _amountInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final availableMaxWidth = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 15, 16, keyBoardSpace + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (availableMaxWidth >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleInput,
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          decoration: const InputDecoration(labelText: "Title"),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountInput,
                          keyboardType: TextInputType.phone,
                          maxLength: 50,
                          decoration: const InputDecoration(
                              prefixText: 'Rs.', labelText: "Amount"),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleInput,
                    keyboardType: TextInputType.text,
                    maxLength: 50,
                    decoration: const InputDecoration(labelText: "Title"),
                  ),
                if (availableMaxWidth >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (Category) => DropdownMenuItem(
                                  value: Category,
                                  child: Text(
                                    Category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      Text(_selectedDate == null
                          ? "Selected Date"
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _datePicker,
                        icon: const Icon(Icons.calendar_today),
                      ),
                      const SizedBox(height: 5),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountInput,
                          keyboardType: TextInputType.phone,
                          maxLength: 50,
                          decoration: const InputDecoration(
                              prefixText: 'Rs.', labelText: "Amount"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // ! mark means that variable wont be null
                      Text(_selectedDate == null
                          ? "Selected Date"
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _datePicker,
                        icon: const Icon(Icons.calendar_today),
                      )
                    ],
                  ),
                const SizedBox(height: 16),
                if (availableMaxWidth >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.cancel),
                            SizedBox(width: 4),
                            Text("Cancel")
                          ],
                        ),
                      ),
                      // const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _validateSubmit,
                        child: const Row(
                          children: [
                            Icon(Icons.done),
                            SizedBox(width: 4),
                            Text("Save Expense")
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (Category) => DropdownMenuItem(
                                  value: Category,
                                  child: Text(
                                    Category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.cancel),
                            SizedBox(width: 4),
                            Text("Cancel")
                          ],
                        ),
                      ),
                      // const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _validateSubmit,
                        child: const Row(
                          children: [
                            Icon(Icons.done),
                            SizedBox(width: 4),
                            Text("Save Expense")
                          ],
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}

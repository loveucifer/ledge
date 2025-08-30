import 'package:flutter/material.dart';
import 'package:ledge/models/expense.dart';
import 'package:ledge/screens/edit_expense_screen.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function(String) onExpenseDeleted;
  final String currencySymbol;

  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onExpenseDeleted,
    required this.currencySymbol,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    if (expenses.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF171717) : const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.receipt_long,
              size: 48,
              color: Color(0xFFD4D4D4),
            ),
            SizedBox(height: 16),
            Text(
              'No expenses yet',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFA3A3A3),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add your first expense to get started',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFD4D4D4),
              ),
            ),
          ],
        ),
      );
    }

    // Sort expenses by date (newest first)
    final sortedExpenses = List<Expense>.from(expenses)
      ..sort((a, b) => b.date.compareTo(a.date));

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedExpenses.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final expense = sortedExpenses[index];
        return Dismissible(
          key: Key(expense.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            onExpenseDeleted(expense.id);
          },
          child: Card(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF171717) : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDarkMode ? const Color(0xFF262626) : const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      expense.category.icon,
                      size: 24,
                      color: Color(expense.category.color),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditExpenseScreen(
                              expense: expense,
                              currencySymbol: currencySymbol,
                            ),
                          ),
                        );
                        
                        if (result == true) {
                          // Refresh the UI if an expense was updated
                          (context as Element).markNeedsBuild();
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expense.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat.yMMMd().format(expense.date),
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? const Color(0xFFA3A3A3) : const Color(0xFF737373),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    NumberFormat.currency(symbol: currencySymbol).format(expense.amount),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
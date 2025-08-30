import 'package:flutter/foundation.dart';
import 'package:ledge/models/expense.dart';
import 'package:ledge/services/local_storage_service.dart';

class ExpenseProvider with ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();
  List<Expense> _expenses = [];
  
  List<Expense> get expenses => _expenses;
  
  ExpenseProvider() {
    _init();
  }
  
  void _init() async {
    await _storageService.init();
    _expenses = _storageService.getExpenses();
    notifyListeners();
  }
  
  // Add a new expense
  Future<void> addExpense(Expense expense) async {
    await _storageService.addExpense(expense);
    _expenses = _storageService.getExpenses();
    notifyListeners();
  }
  
  // Update an existing expense
  Future<void> updateExpense(Expense updatedExpense) async {
    await _storageService.updateExpense(updatedExpense);
    _expenses = _storageService.getExpenses();
    notifyListeners();
  }
  
  // Delete an expense
  Future<void> deleteExpense(String id) async {
    await _storageService.deleteExpense(id);
    _expenses = _storageService.getExpenses();
    notifyListeners();
  }
  
  // Get expenses for a specific month
  List<Expense> getExpensesForMonth(DateTime month) {
    return _expenses.where((expense) {
      return expense.date.year == month.year && 
             expense.date.month == month.month;
    }).toList();
  }
  
  // Get total expenses for a specific month
  double getTotalExpensesForMonth(DateTime month) {
    return getExpensesForMonth(month).fold(0, (sum, expense) => sum + expense.amount);
  }
  
  // Get expenses grouped by category for a specific month
  Map<String, double> getExpensesByCategoryForMonth(DateTime month) {
    final monthlyExpenses = getExpensesForMonth(month);
    final Map<String, double> categoryTotals = {};
    
    for (final expense in monthlyExpenses) {
      final categoryName = expense.category.name;
      if (categoryTotals.containsKey(categoryName)) {
        categoryTotals[categoryName] = categoryTotals[categoryName]! + expense.amount;
      } else {
        categoryTotals[categoryName] = expense.amount;
      }
    }
    
    return categoryTotals;
  }
  
  // Get daily expenses for a specific month
  Map<int, double> getDailyExpensesForMonth(DateTime month) {
    final monthlyExpenses = getExpensesForMonth(month);
    final Map<int, double> dailyTotals = {};
    
    for (final expense in monthlyExpenses) {
      final day = expense.date.day;
      if (dailyTotals.containsKey(day)) {
        dailyTotals[day] = dailyTotals[day]! + expense.amount;
      } else {
        dailyTotals[day] = expense.amount;
      }
    }
    
    return dailyTotals;
  }
}
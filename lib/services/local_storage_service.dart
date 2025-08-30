import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ledge/models/expense.dart';

class LocalStorageService {
  static const String _expensesKey = 'expenses';
  
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get all expenses
  List<Expense> getExpenses() {
    final expensesJson = _prefs.getStringList(_expensesKey) ?? [];
    return expensesJson
        .map((jsonString) => Expense.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  // Add a new expense
  Future<void> addExpense(Expense expense) async {
    final expenses = getExpenses();
    expenses.add(expense);
    await _saveExpenses(expenses);
  }

  // Update an existing expense
  Future<void> updateExpense(Expense updatedExpense) async {
    final expenses = getExpenses();
    final index = expenses.indexWhere((expense) => expense.id == updatedExpense.id);
    if (index != -1) {
      expenses[index] = updatedExpense;
      await _saveExpenses(expenses);
    }
  }

  // Delete an expense
  Future<void> deleteExpense(String id) async {
    final expenses = getExpenses();
    expenses.removeWhere((expense) => expense.id == id);
    await _saveExpenses(expenses);
  }

  // Save expenses to shared preferences
  Future<void> _saveExpenses(List<Expense> expenses) async {
    final expensesJson = expenses
        .map((expense) => jsonEncode(expense.toJson()))
        .toList();
    await _prefs.setStringList(_expensesKey, expensesJson);
  }

  // Clear all expenses (for testing purposes)
  Future<void> clearAllExpenses() async {
    await _prefs.remove(_expensesKey);
  }
}
import 'package:flutter/material.dart';
import 'package:ledge/models/category.dart';

class PredefinedCategories {
  static const List<Category> categories = [
    Category(
      id: 'food',
      name: 'Food',
      icon: Icons.restaurant,
      color: 0xFF10B981, // Emerald Green
    ),
    Category(
      id: 'transportation',
      name: 'Transportation',
      icon: Icons.directions_car,
      color: 0xFF3B82F6, // Electric Blue
    ),
    Category(
      id: 'entertainment',
      name: 'Entertainment',
      icon: Icons.movie,
      color: 0xFFF59E0B, // Warm Orange
    ),
    Category(
      id: 'shopping',
      name: 'Shopping',
      icon: Icons.shopping_cart,
      color: 0xFF8B5CF6, // Purple
    ),
    Category(
      id: 'bills',
      name: 'Bills',
      icon: Icons.receipt,
      color: 0xFFF97316, // Coral Red
    ),
    Category(
      id: 'health',
      name: 'Health',
      icon: Icons.local_hospital,
      color: 0xFFEAB308, // Golden Yellow
    ),
    Category(
      id: 'education',
      name: 'Education',
      icon: Icons.school,
      color: 0xFFEC4899, // Pink
    ),
    Category(
      id: 'other',
      name: 'Other',
      icon: Icons.more_horiz,
      color: 0xFF06B6D4, // Cyan
    ),
  ];

  static Category getCategoryById(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } on StateError {
      return categories.last; // Return 'Other' category as fallback
    }
  }
}
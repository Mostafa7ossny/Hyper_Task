part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {
  final String selectedcategory;

  CategoryInitial({required this.selectedcategory});
}

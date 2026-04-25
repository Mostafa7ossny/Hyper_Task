import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial(selectedcategory: 'All'));

  void selectCategory(String category) {
    emit(CategoryInitial(selectedcategory: category));
  }
}

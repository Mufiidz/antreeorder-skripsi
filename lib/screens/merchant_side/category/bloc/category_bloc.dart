import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/models/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final AntreeDatabase _antreeDatabase;
  CategoryBloc(this._antreeDatabase) : super(const CategoryState([])) {
    final categoryDao = _antreeDatabase.categoryDao;
    on<AddCategory>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await categoryDao.categories();
        final data = response.map((e) => e.title).toList();
        final String category = event.category;
        final isExist = data.contains(category);
        if (isExist) {
          emit(state.copyWith(
              status: StatusState.failure, message: '$category sudah ada'));
        } else {
          await categoryDao.addCategory(category);
          final response = await categoryDao.categories();
          var categories = ["No Category"];
          var data = response.map((e) => e.title).toList();
          categories.addAll(data);
          emit(state.copyWith(
              status: StatusState.success,
              data: categories,
              message: 'Berhasil menambahkan $category'));
        }
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: '$e'));
      }
    });
    on<GetCategory>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await categoryDao.categories();
        var categories = ["No Category"];
        var data = response.map((e) => e.title).toList();
        categories.addAll(data);
        emit(state.copyWith(data: categories, status: StatusState.idle));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: '$e'));
      }
    });
    on<DeleteCategory>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final String category = event.category;
        await categoryDao.deleteCategory(category);
        final response = await categoryDao.categories();
        var categories = ["No Category"];
        var data = response.map((e) => e.title).toList();
        categories.addAll(data);
        emit(state.copyWith(
            status: StatusState.success,
            data: categories,
            message: 'Berhasil menghapus $category'));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: '$e'));
      }
    });
  }
}

part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class AddCategory extends CategoryEvent {
  final String category;

  const AddCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class GetCategory extends CategoryEvent {
  @override
  List<Object?> get props => [];
}

class DeleteCategory extends CategoryEvent {
  final String category;

  const DeleteCategory(this.category);

  @override
  List<Object?> get props => [category];
}

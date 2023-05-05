part of 'category_bloc.dart';

class CategoryState extends BaseState<List<String>> {
  const CategoryState(super.data, {super.message, super.status});

  @override
  List<Object> get props => [data, message, status];

  CategoryState copyWith({
    List<String>? data,
    StatusState? status,
    String? message,
  }) {
    return CategoryState(data ?? this.data,
        status: status ?? this.status, message: message ?? this.message);
  }
}

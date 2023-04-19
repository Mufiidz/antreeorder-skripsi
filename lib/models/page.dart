import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page.g.dart';

@JsonSerializable()
class Page extends Equatable {
  final int size;
  final int total;
  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'total_page')
  final int totalPage;

  const Page({
    this.size = 5,
    this.total = 1,
    this.currentPage = 1,
    this.totalPage = 1,
  });

  Page copyWith({
    int? size,
    int? total,
    int? currentPage,
    int? totalPage,
  }) {
    return Page(
      size: size ?? this.size,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  factory Page.fromJson(Map<String, dynamic> data) => _$PageFromJson(data);

  Map<String, dynamic> toJson() => _$PageToJson(this);

  @override
  List<Object> get props => [size, total, currentPage, totalPage];

  @override
  String toString() {
    return 'Page(size: $size, total: $total, currentPage: $currentPage, totalPage: $totalPage)';
  }
}

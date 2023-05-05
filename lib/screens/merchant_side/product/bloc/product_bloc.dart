import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/config/local/category_dao.dart';
import 'package:antreeorder/models/base_state.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/repository/merchant_repository.dart';
import 'package:antreeorder/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  final MerchantRepository _merchantRepository;
  final AntreeDatabase _antreeDatabase;
  ProductBloc(
      this._productRepository, this._merchantRepository, this._antreeDatabase)
      : super(ProductState(Product())) {
    final CategoryDao categoryDao = _antreeDatabase.categoryDao;
    on<AddProduct>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await _productRepository.addProduct(event.product);
        final data = response.data;
        emit(data != null
            ? state.copyWith(
                data: data,
                status: StatusState.success,
                message: response.message)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "ERROR"));
      }
    }, transformer: restartable());
    on<MerchantProducts>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response =
            await _merchantRepository.getMerchantProduct(event.merchantId);
        final data = response.data;
        emit(data != null
            ? state.copyWith(products: data, status: StatusState.idle)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "ERROR"));
      }
    }, transformer: restartable());
    on<UpdateProduct>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await _productRepository.updateProduct(event.product);
        final data = response.data;
        emit(data != null
            ? state.copyWith(
                data: data,
                status: StatusState.success,
                message: "Product ${data.title} berhasil diperbarui")
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "ERROR"));
      }
    });
    on<DeleteProduct>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response =
            await _productRepository.deleteProduct(event.productId);
        final data = response.data;
        emit(data != null
            ? state.copyWith(message: data, status: StatusState.success)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: "ERROR"));
      }
    });
    on<GetCategory>((event, emit) async {
      final response = await categoryDao.categories();
      var categories = ["No Category"];
      var data = response.map((e) => e.title).toList();
      categories.addAll(data);
      emit(state.copyWith(categories: categories));
    });
    on<Initial>(
        (event, emit) => emit(state.copyWith(status: StatusState.idle)));
  }
}

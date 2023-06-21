import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/data/local/dao/category_dao.dart';
import 'package:antreeorder/models/base_response.dart';
import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/product.dart';
import 'package:antreeorder/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  final AntreeDatabase _antreeDatabase;
  ProductBloc(
    this._productRepository,
    this._antreeDatabase,
  ) : super(ProductState(Product())) {
    final CategoryDao categoryDao = _antreeDatabase.categoryDao;
    on<AddProduct>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final response =
          await _productRepository.addProduct(event.product, event.file);
      final newState = response.when(
        data: (data, meta) => state.copyWith(
            status: StatusState.success,
            data: data,
            message: 'Berhasil menambahkan produk \'${data.title}\'',
            xfile: null),
        error: (message) =>
            state.copyWith(status: StatusState.failure, message: message),
      );
      emit(newState);
    });
    on<MerchantProducts>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final response =
          await _productRepository.getMerchantProducts(page: event.page);
      final newState = response.when(
        data: (data, meta) {
          final page = meta?.pagination ?? Pagination();
          final isLastPage = page.page == page.pageCount;
          return state.copyWith(
              products: data,
              status: StatusState.idleList,
              isLastPage: isLastPage);
        },
        error: (message) =>
            state.copyWith(status: StatusState.failure, message: message),
      );
      emit(newState);
    });
    on<UpdateProduct>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final response =
          await _productRepository.updateProduct(event.product, event.file);
      final newState = response.when(
        data: (data, meta) => state.copyWith(
            status: StatusState.success,
            data: data,
            message: 'Product \'${data.title}\' berhasil diperbarui',
            xfile: null),
        error: (message) =>
            state.copyWith(status: StatusState.failure, message: message),
      );
      emit(newState);
    });
    on<DeleteProduct>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final response = await _productRepository.deleteProduct(event.product);
      final newState = response.when(
        data: (data, meta) => state.copyWith(
          status: StatusState.success,
          message: 'Product berhasil dihapus',
        ),
        error: (message) =>
            state.copyWith(status: StatusState.failure, message: message),
      );
      emit(newState);
    });
    on<GetCategory>((event, emit) async {
      final response = await categoryDao.categories();
      var categories = ["No Category"];
      var data = response.map((e) => e.title).toList();
      categories.addAll(data);
      emit(state.copyWith(categories: categories, status: StatusState.idle));
    });
    on<AddImage>((event, emit) => emit(state.copyWith(xfile: event.image)));
  }
}

part of 'merchant_bloc.dart';

abstract class MerchantEvent extends Equatable {
  const MerchantEvent();

  @override
  List<Object> get props => [];
}

class GetMerchants extends MerchantEvent {
  final int page;

  const GetMerchants({this.page = 1});

  @override
  List<Object> get props => [page];
}

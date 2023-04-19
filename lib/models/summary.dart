class Summary {
  final String title;
  final int price;
  Summary({
    this.title = '',
    this.price = 0,
  });

  @override
  String toString() => 'Summary(title: $title, price: $price)';
}

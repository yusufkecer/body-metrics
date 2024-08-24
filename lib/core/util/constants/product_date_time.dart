final class ProductDateTime extends DateTime {
  ProductDateTime(super.year);
  ProductDateTime.now() : super.now();
  ProductDateTime.birthLastDate() : super(1900);
  ProductDateTime.birthInitialDate() : super(1999);
}

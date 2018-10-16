import 'package:meta/meta.dart';

class PaymentModel {
  PaymentModel({
    @required this.ID,
    @required this.PRODUCT_NAME,
    @required this.PRICE,
    @required this.RECORD_DATE,

  });

  int ID;
  String PRODUCT_NAME, PRICE,RECORD_DATE;

  PaymentModel.fromMap(Map map)
      : ID = map["ID"],
  //map içindeki alan apiden gelen ID nin karlşılığı olan alanın adı
        PRODUCT_NAME = map["PRODUCT_NAME"],
        PRICE = map["PRICE"],
        RECORD_DATE = map["RECORD_DATE"];
}
import 'package:meta/meta.dart';

class ProductModel {
  ProductModel({
    @required this.PRODUCT_ID,
    @required this.PRODUCT_NAME,
    this.PRODUCT_STATUS,
    this.PRODUCT_CAT_ID,
    this.PRODUCT_RECORD_DATE,
    this.PRODUCT_RECORD_TIME,
    this.PRODUCT_UPDATE_DATE,
    this.PRODUCT_UPDATE_TIME,
  });

  int PRODUCT_ID, PRODUCT_STATUS, PRODUCT_CAT_ID;
  String PRODUCT_NAME, PRODUCT_RECORD_DATE, PRODUCT_RECORD_TIME,
      PRODUCT_UPDATE_DATE, PRODUCT_UPDATE_TIME;

  ProductModel.fromMap(Map map)
      : PRODUCT_ID = map["PRODUCT_ID"],
  //map içindeki alan apiden gelen ID nin karlşılığı olan alanın adı
        PRODUCT_NAME = map["PRODUCT_NAME"],
        PRODUCT_STATUS = map["PRODUCT_STATUS"],
        PRODUCT_RECORD_DATE = map["PRODUCT_RECORD_DATE"],
        PRODUCT_RECORD_TIME = map["PRODUCT_RECORD_TIME"],
        PRODUCT_UPDATE_DATE = map["PRODUCT_UPDATE_DATE"],
        PRODUCT_UPDATE_TIME = map["PRODUCT_UPDATE_TIME"];
}
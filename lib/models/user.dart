import 'package:meta/meta.dart';

class UserModel {
  UserModel({
    this.ID,
    this.STATUS,
    @required this.EMAIL,
    @required this.PASSWORD,
    this.RECORD_DATE,
    this.UPDATE_DATE,
  });

  int ID, STATUS;
  String EMAIL, PASSWORD, RECORD_DATE, UPDATE_DATE;

  UserModel.fromMap(Map map)
      : ID = map["ID"],
  //map içindeki alan apiden gelen ID nin karlşılığı olan alanın adı
        STATUS = map["STATUS"],
        EMAIL = map["EMAIL"],
        PASSWORD = map["PASSWORD"],
        RECORD_DATE = map["RECORD_DATE"],
        UPDATE_DATE = map["UPDATE_DATE"];
}
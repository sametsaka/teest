import 'dart:async';
import 'dart:io' as IO;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teest/models/payment.dart';
import 'package:teest/models/user.dart';

class DbHelper {
  final String USER = 'User';
  final String PRODUCT = 'Product';
  final String PAYMENT = 'Payment';
  static Database MyDatabase;

  Future<Database> get db async {
    if (MyDatabase == null) MyDatabase = await initDb();
    return MyDatabase;
  }

  initDb() async {
    IO.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'FirstDB.db');
    var db = await openDatabase(path, version: 1, onCreate: dbOlusurken);
    return db;
  }

  void dbOlusurken(Database db, int version) async {
    await db.execute('CREATE TABLE $USER('
        'ID INTEGER PRIMARY KEY AUTOINCREMENT,EMAIL TEXT, PASSWORD TEXT, STATUS INTEGER,'
        'RECORD_DATE TEXT, UPDATE_DATE TEXT);');

    await db.execute('CREATE TABLE $PRODUCT('
        'PRODUCT_ID INTEGER PRIMARY KEY AUTOINCREMENT,PRODUCT_NAME TEXT,PRODUCT_STATUS INTEGER,PRODUCT_CAT_ID INTEGER'
        'PRODUCT_RECORD_DATE TEXT,PRODUCT_RECORD_TIME TEXT,PRODUCT_UPDATE_DATE TEXT, PRODUCT_UPDATE_TIME TEXT);');

    await db.execute('CREATE TABLE $PAYMENT('
        'ID INTEGER PRIMARY KEY AUTOINCREMENT,PRODUCT_NAME TEXT,PRICE TEXT);');
  }

//USER MODEL
  Future<List<UserModel>> getUsers() async {
    var getDb = await db;
    List<Map> mapList = await getDb.rawQuery('SELECT * FROM $USER');
    List<UserModel> userList = new List();
    for (int i = 0; i < mapList.length; i++) {
      UserModel userModel = new UserModel(EMAIL: null, PASSWORD: null);
      userModel.ID = mapList[i]['ID'];
      userModel.STATUS = mapList[i]['STATUS'];
      userModel.EMAIL = mapList[i]['EMAIL'];
      userModel.PASSWORD = mapList[i]['PASSWORD'];
      userModel.RECORD_DATE = mapList[i]['RECORD_DATE'];
      userModel.UPDATE_DATE = mapList[i]['UPDATE_DATE'];
      userList.add(userModel);
    }
    return userList;
  }

  Future<UserModel> getUser(String EMAIL, String PASSWORD) async {
    var getDb = await db;
    List<Map> maps = await getDb.query(USER,
        columns: [
          'ID',
          'EMAIL',
          'PASSWORD',
          'STATUS',
          'RECORD_DATE',
          'UPDATE_DATE'
        ],
        where: "EMAIL = ? AND PASSWORD = ?",
        whereArgs: [EMAIL, PASSWORD]);
    if (maps.length > 0) {
      return new UserModel.fromMap(maps.first);
    }
    return null;
  }

  void insertNewUser(UserModel userModel) async {
    var getDb = await db;
    String sqlQuery = 'INSERT INTO $USER(EMAIL,PASSWORD,STATUS,RECORD_DATE) '
        'VALUES( \'${userModel.EMAIL}\',\'${userModel.PASSWORD}\',${userModel.STATUS},'
        '\'${userModel.RECORD_DATE}\')';

    await getDb.transaction((transaction) async {
      return await transaction.rawInsert(sqlQuery);
    });
  }

  void deleteNewUser(int ID) async {
    var getDb = await db;
    String sqlQuery = 'DELETE FROM $USER WHERE ID =$ID';
    await getDb.transaction((transaction) async {
      return await transaction.rawQuery(sqlQuery);
    });
  }

  //USER MODEL
//PAYMENT MODEL
  void insertNewPayment(PaymentModel paymentModel) async {
    var getDb = await db;
    String sqlQuery = 'INSERT INTO $PAYMENT(PRODUCT_NAME,PRICE,RECORD_DATE) '
        'VALUES( \'${paymentModel.PRODUCT_NAME}\',\'${paymentModel.PRICE}\','
        '\'${paymentModel.RECORD_DATE}\')';

    await getDb.transaction((transaction) async {
      return await transaction.rawInsert(sqlQuery);
    });
  }

  Future<List<PaymentModel>> getPayment() async {
    var getDb = await db;
    List<Map> mapList = await getDb.rawQuery('SELECT * FROM $PAYMENT');
    List<PaymentModel> paymentList = new List();
    for (int i = 0; i < mapList.length; i++) {
      PaymentModel psymentModel = new PaymentModel(
          ID: null, PRODUCT_NAME: null, PRICE: null, RECORD_DATE: null);
      psymentModel.ID = mapList[i]['ID'];
      psymentModel.PRODUCT_NAME = mapList[i]['PRODUCT_NAME'];
      psymentModel.PRICE = mapList[i]['PRICE'];
      psymentModel.RECORD_DATE = mapList[i]['RECORD_DATE'];
      paymentList.add(psymentModel);
    }
    return paymentList;
  }
//PAYMENT MODEL
}

import 'package:deapplication/productview/productview.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDataBase {
  Future<Database> ForGetDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'munewdata.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE data (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, EMAIL TEXT,PASSWORD TEXT )');

      await db.execute(
          'CREATE TABLE productdata (ID INTEGER PRIMARY KEY AUTOINCREMENT, product_name TEXT,MRP TEXT,contect_no TEXT,description TEXT,location TEXT,pincode TEXT,url TEXT,min_qut TEXT,actual_price TEXT,rating TEXT ,category TEXT,like bool)');
      await db.execute(
          'CREATE TABLE cartdata (ID INTEGER PRIMARY KEY AUTOINCREMENT, product_name TEXT,MRP TEXT  ,contect_no TEXT,description TEXT,location TEXT,pincode TEXT,url TEXT,min_qut TEXT,actual_price TEXT,rating TEXT ,category TEXT)');
    });

    return database;
  }

  Future<void> insertdata(
      String name, String email, Database database, String passwd) async {
    print(
        "-----------------------------------$database-------------------------");
    String insertsql =
        "INSERT INTO data (NAME,EMAIL,PASSWORD) VALUES('$name','$email','$passwd')";
    int a = await database!.rawInsert(insertsql);
  }

  Future<List<Map>> forlogindata(
      String Email, String passs, Database database) async {
    String verify =
        "Select * from data where EMAIL = '$Email' and PASSWORD='$passs'";
    List<Map> ll = await database.rawQuery(verify);
    print("--------------------------------------------------${ll}");
    return ll;
  }
  Future<List<Map>> foruserdata(Database database) async {
    String verify =
        "Select * from data ";
    List<Map> ll = await database.rawQuery(verify);
    print("--------------------------------------------------${ll}");
    return ll;
  }




  void foraddjsondata(
      String id,
      String productname,
      String mrp,
      String conteactno,
      String description,
      String location,
      String pincode,
      String uRl,
      String mInqut,
      String actualprice,
      String rating,
      String category,
      bool like,
      Database database) async {
    String jsondataadd =
        "INSERT INTO productdata (ID,product_name,MRP,contect_no,description,location,pincode,url,min_qut,actual_price,rating,category,like) VALUES('$id','$productname','$mrp','$conteactno','$description','$location','$pincode','$uRl','$mInqut','$actualprice','$rating','$category','false')";
    var a = await database.rawInsert(jsondataadd);
  }

  Future<List<Map<String, Object?>>> forviewproduct(Database database) async {
    String viewproduct = "SELECT * FROM productdata";
    var b = await database.rawQuery(viewproduct);
    return b;
  }

  Future<void> foraddproductdata(
      String productname1,
      String mrp,
      String contectno,
      String description,
      String location,
      String pincode,
      String url,
      String minquality,
      String actucalprice,
      String rating,
      String category,
      Database database) async {
    String insertproduct =
        "INSERT INTO productdata (product_name,MRP,contect_no,description,location,pincode,url,min_qut,actual_price,rating,category) VALUES('$productname1','$mrp','$contectno','$description','$location','$pincode','$url','$minquality','$actucalprice','$rating','$category')";
    var a = await database.rawInsert(insertproduct);
  }

  Future<void> forinstertcartvalue(

      String productname1,
      String mrp,
      String contectno,
      String description,
      String location,
      String pincode,
      String url,
      String minquality,
      String actucalprice,
      String rating,
      String category,
      Database database) async {
    String insertcart =
        "INSERT INTO cartdata (product_name,MRP,contect_no,description,location,pincode,url,min_qut,actual_price,rating,category) VALUES('$productname1','$mrp','$contectno','$description','$location','$pincode','$url','$minquality','$actucalprice','$rating','$category')";
    var cart = await database.rawInsert(insertcart);
  }

  Future<List<Map<String, Object?>>> forviewcartproduct(Database database) async {
    String viewcartproduct = "SELECT * FROM cartdata";
    var b = await database.rawQuery(viewcartproduct);
    return b;
  }

   static Future<int>  fordeltecartproduct(Database database, qualityno)  async {
    String deletedata =
        "DELETE FROM cartdata WHERE product_name='$qualityno'";
    var a = await database.rawDelete(deletedata);
    return a;


  }

  Future<List<Map>> forcheckcartproduct(viewproduct, Database db) async {
    String check = "SELECT * FROM cartdata WHERE product_name='$viewproduct'";
    List<Map> ll = await db.rawQuery(check);
    print("--------------------------------------------------${ll}");
    return ll;
  }

  Future<void> foraddlike(bool likeproduct, viewproduct, Database database) async {
    String insertsql =
        "UPDATE  productdata SET like='$likeproduct' WHERE product_name='$viewproduct'";
    int a = await database.rawInsert(insertsql);
  }

  Future<List<Map>> ForShowlikeproduct(Database database) async {
    String check = "SELECT * FROM productdata WHERE like='true'";
    List<Map> ll = await database.rawQuery(check);
    print("--------------------------------------------------${ll}");
    return ll;
  }

  static Future<void> forpricechange(Database database, qualityno, double quliprice) async {
    String insertsql =
        "UPDATE  cartdata SET min_qut='$quliprice' WHERE product_name='$qualityno'";
    int a = await database.rawInsert(insertsql);
  }



}


import 'package:deapplication/database/Database.dart';
import 'package:flutter/material.dart';
import 'package:deapplication/homepage/homepage.dart';
import 'package:deapplication/homepage/loginpage.dart';


class likeproductes extends StatefulWidget {
  @override
  State<likeproductes> createState() => _likeproductesState();
}

class _likeproductesState extends State<likeproductes> {
  var likeproduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("----------------------------");
    print("${likeproduct}!!!!!!!!!!!!!!!!!!!@@@@@@@@@");
    print("like length => ${likeproduct.length}");
    forshowlikeproduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Like Product"),backgroundColor: Color(0xff62B6B7)),
      body: Container(
        child: ListView.builder(
          // itemCount: homepage.likedata.length,
          itemCount: likeproduct.length,

          itemBuilder: (context, index) {
            return Container(

              // color: Colors.lightBlueAccent,
              margin: EdgeInsets.all(10),
              height: 100,
              child: Card(
                elevation: 5,
                child: ListTile(
                  
                    visualDensity: VisualDensity(vertical: 4),
                    title: Text("${likeproduct[index]['product_name']}"),
                    subtitle: Text("Price:${likeproduct[index]['MRP']}.00"),
                    leading: Image.network(
                      "${likeproduct[index]['url']}",
                      fit: BoxFit.fill,
                    ),
                    // trailing: PopupMenuButton(itemBuilder: (context) {
                    //   return [
                    //     PopupMenuItem(child: InkWell(
                    //         onTap: () {
                    //           print("Tap on delete button");
                    //         },
                    //         child: Text('Delete'))
                    //     )];
                    // },)
            ),
              ),
            );
          },
        ),
      ),
    );
  }

  void forshowlikeproduct() {
    MyDataBase().ForShowlikeproduct(signin.db!).then((value) {
      setState(() {
        likeproduct= value;
        print("likeproduct list ==>${likeproduct}");
      });
    },);
  }
}

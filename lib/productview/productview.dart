import 'package:deapplication/bottamnavigationpage/likeproduct.dart';
import 'package:deapplication/database/Database.dart';
import 'package:deapplication/homepage/homepage.dart';
import 'package:deapplication/homepage/loginpage.dart';
import 'package:deapplication/productview/cartshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class productview extends StatefulWidget {
  var viewproduct;
  static var cartviewprosuct = [];

  productview(this.viewproduct);

  @override
  State<productview> createState() => _productviewState();

// Text("${widget.viewproduct['ID']}"),
}

class _productviewState extends State<productview> {
  bool satus = false;
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff62B6B7),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return likeproductes();
                    },
                  ));
                },
                icon: Icon(Icons.favorite_border))
          ],
          title: Text("${widget.viewproduct['product_name']}"),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10),
              elevation: 10,
              child: Container(
                // color: Color(0xff62B6B7),
                height: 350,
                width: 500,
                padding: EdgeInsets.all(10),
                child: Image.network(
                  "${widget.viewproduct['url']}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              // color: Colors.red,
              height: 290,

              margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.viewproduct['product_name']}",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Text(
                    "₹${widget.viewproduct['MRP']}.00",
                    style: TextStyle(color: Color(0xff949494)),
                  ),
                  // Text("${widget.viewproduct['rating']}☆"),
                  RatingBar.builder(
                    initialRating: double.parse(widget.viewproduct['MRP']),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  // RatingBar(
                  //   initialRating: 3,
                  //   direction: Axis.horizontal,
                  //   allowHalfRating: true,
                  //   itemCount: 5,
                  //   ratingWidget: RatingWidget(
                  //     full: _image('assets/heart.png'),
                  //     half: _image('assets/heart_half.png'),
                  //     empty: _image('assets/heart_border.png'),
                  //   ),
                  //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  //   onRatingUpdate: (rating) {
                  //     print(rating);
                  //   },
                  // );
                  Text("Category : ${widget.viewproduct['category']}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    " ${widget.viewproduct['description']}\n",
                    maxLines: satus ? 10 : 3,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          satus = !satus;
                        });
                      },
                      child: Text(
                        "Seemore",
                        style: TextStyle(color: Color(0xff62B6B7)),
                      ))
                ],
              ),
            ),
            Container(
              // color: Colors.green,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Price"),
                        Text(
                          "₹${widget.viewproduct['MRP']}.00",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        print(
                            "product name =>${widget.viewproduct['product_name']}");
                        MyDataBase()
                            .forcheckcartproduct(
                                widget.viewproduct['product_name'], signin.db!)
                            .then(
                              (value) {
                                if(value.length == 1)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: const Text("Product Alredy added."),
                                    duration: const Duration(seconds: 1),
                                  ));
                                }
                                else
                                {
                                    MyDataBase().forinstertcartvalue(

                                              widget.viewproduct['product_name'],
                                              widget.viewproduct['MRP'],
                                              widget.viewproduct['contect_no'],
                                              widget.viewproduct['description'],
                                              widget.viewproduct['location'],
                                              widget.viewproduct['pincode'],
                                              widget.viewproduct['url'],
                                              widget.viewproduct['min_qut'],
                                              widget.viewproduct['actual_price'],
                                              widget.viewproduct['rating'],
                                              widget.viewproduct['category'],
                                              signin.db!
                                          );
                                    productview.cartviewprosuct.add(widget.viewproduct);
                                      print("${productview.cartviewprosuct}----------------------------------------------------");
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return cartview();
                                        },
                                      ));
                                  }


                              },
                            );

                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff62B6B7)),
                        child: Center(
                            child: Text("Add to Cart",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white))),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

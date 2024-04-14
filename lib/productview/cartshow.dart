import 'package:deapplication/database/Database.dart';
import 'package:deapplication/homepage/homepage.dart';
import 'package:deapplication/homepage/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';



class cartview extends StatefulWidget {
  const cartview({Key? key}) : super(key: key);

  @override
  State<cartview> createState() => _cartviewState();
}

class _cartviewState extends State<cartview> {
  int quality = 0;
  var qualityno = [];
  int produt = 0;
  double totalprice = 0;
  double QualityShow = 0;

  List<double> quliprice = [];
  Razorpay razorpay = Razorpay();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forviewchatproduct();
    forpaymentcalculation();
    print("cart lenth =>${qualityno.length}");
    for (int i = 0; i < qualityno.length; i++) {
      print("total price=>${qualityno}");


      // for(int i=0 ; i<qualityno.length;i++)
      // {
      //   // print("3333333${quliprice[0]}");
      //
      //   String minqut = "${qualityno[i]['min_qut']}";
      //   double Quality = double.parse(minqut);
      //   // double Quality = double.parse("${quliprice[i]}");
      //   String Price = "${qualityno[i]['actual_price']}";
      //   double ProductPrice = double.parse(Price);
      //   print("Quality=>${Quality}");
      //   print("ProductPrice => ${ProductPrice}");
      //   setState(() {
      //     // totalprice = totalprice + ((Quality) * (ProductPrice));
      //     totalprice = totalprice + ((Quality) * (ProductPrice));
      //   });
      //
      //   print(" product mrp ==>${totalprice}");
      // }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Your Cart"), backgroundColor: Color(0xff62B6B7)),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                  "₹${totalprice}"
                // "${qualityno[1]["MRP"]}"
              ),
              ElevatedButton(
                onPressed: () {
                  var options = {
                    'key': 'rzp_test_3UfIzjJt9Ygpy7',
                    'amount': "${totalprice*100}",
                    'name': 'Acme Corp.',
                    'description': 'Fine T-Shirt',
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {
                      'contact': '8888888888',
                      'email': 'test@razorpay.com'
                    },
                    'external': {
                      'wallets': ['paytm']
                    }
                  };
                  razorpay.on(
                      Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                      handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                      handleExternalWalletSelected);
                  razorpay.open(options);
                  // Implement checkout logic here
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
        body: Container(
          child: ListView(
              children: List.generate(

                qualityno.length,
                    (index) {
                  return Slidable(
                    endActionPane: ActionPane(
                        motion: BehindMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            print("tap on delete==");
                            MyDataBase.fordeltecartproduct(
                                signin.db!, qualityno[index]['product_name'])
                                .then(
                                  (value) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return homepage();
                                      },
                                    ));
                              },
                            );
                          });
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: "Delete",
                      )
                    ]),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      // color: Colors.black,
                      height: 120,
                      child: Card(
                        elevation: 5,
                        child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Image.network(
                                    "${qualityno[index]['url']}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  width: 163,
                                  // color: Colors.pink,
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          "\t ${qualityno[index]['product_name']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                            "\t ₹${qualityno[index]['MRP']}.00")
                                      ]),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xffC4DFDF)),
                                  width: 70,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff62B6B7)),
                                        height: 32,
                                        child: IconButton(
                                            onPressed: () {

                                            },
                                            icon: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  quliprice[index] =
                                                      quliprice[index] - 1.0;

                                                  MyDataBase.forpricechange(
                                                      signin.db!,
                                                      qualityno[index]['product_name'],
                                                      quliprice[index]).then((
                                                      value) {
                                                    forpaymentcalculation();
                                                  });
                                                });
                                              },
                                              child: Center(
                                                  child: Text(
                                                    "-",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            )),
                                      ),
                                      Container(
                                        child: Center(


                                          child: Text("${quliprice[index]}"),
                                        ),
                                        height: 30,
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff62B6B7)),
                                        height: 30,
                                        child: IconButton(
                                            onPressed: () {
//                                           String prod =
//                                               "${qualityno[index]['min_qut']}";
//                                           produt = int.parse(prod);
//                                           // String ProductQuo = "${qualityno[index]['min_qut']}" ;
//                                            QualityShow = double.parse(prod);
//                                           print("${prod}+-+-+-+-");
//                                           print("${produt}+-+-+-+-+");
//                                           print("${QualityShow}+-+-+-+-+");
//                                           // double quantity = double.parse(prod);
//                                           // print("${quality}++++++");
// // MyDataBase().updatequantity(signin.db!,)
//                                           setState(() {
//                                             // produt = produt + 1;
//                                             QualityShow = QualityShow + 1;
//                                             print("${produt}/*/*/*");
//                                           });
                                            },
                                            icon: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  quliprice[index] =
                                                      quliprice[index] + 1.0;
                                                  // QualityShow = QualityShow + 1.0;
                                                  print(QualityShow);
                                                  MyDataBase.forpricechange(
                                                      signin.db!,
                                                      qualityno[index]['product_name'],
                                                      quliprice[index]).then(
                                                        (value) {
                                                      forpaymentcalculation();
                                                    },
                                                  );
                                                });
                                              },
                                              child: Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  )),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  );
                },
              )),
        ));
  }

  void forviewchatproduct() {
    MyDataBase().forviewcartproduct(signin.db!).then(
          (value) {
        setState(() {
          qualityno = value;
          print("${qualityno.length}+-*//*-+");

          print("+-*/${qualityno}");
          for (int i = 0; i < qualityno.length; i++) {
            // print(" product mrp ==>${qualityno[i]['MRP']}");
            print(" ${qualityno[i]['MRP']}");
            String ProductQuo = "${qualityno[i]['min_qut']}";
            double Quality = double.parse(ProductQuo);
            print(Quality);
            quliprice.add(Quality);
            print("price ==>${quliprice[0]}");
            forpaymentcalculation();
            // totalprice = totalprice + (());
          }
        });
      },
    );
  }

  void forpaymentcalculation() {
    print("999999999999999999999999999999999${qualityno}");
// print("${qualityno[1]["MRP"]}");
    setState(() {
      for (int i = 0; i < qualityno.length; i++) {
        // print("3333333${quliprice[0]}");

        String minqut = "${qualityno[i]['min_qut']}";
        double Quality = double.parse(minqut);
        // double Quality = double.parse("${quliprice[i]}");
        String Price = "${qualityno[i]['actual_price']}";
        double ProductPrice = double.parse(Price);
        print("Quality=>${Quality}");
        print("ProductPrice => ${ProductPrice}");
        setState(() {
          // totalprice = totalprice + ((Quality) * (ProductPrice));
          totalprice = totalprice + ((Quality) * (ProductPrice));
        });

        print(" product mrp ==>${totalprice}");
      }
    });
  }

// calculateTotal() {
//   double total = 0;
//   // for (var cartItem in cartItems) {
//     total += Text("500");
//   // }
//   return total;
// }
  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response
            .message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }
}

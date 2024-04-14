import 'package:deapplication/bottamnavigationpage/ProfilePage.dart';
import 'package:deapplication/bottamnavigationpage/likeproduct.dart';
import 'package:deapplication/database/Database.dart';
import 'package:deapplication/homepage/loginpage.dart';
import 'package:deapplication/jsondata/json.dart';
import 'package:deapplication/productview/cartshow.dart';
import 'package:deapplication/productview/productview.dart';
import 'package:deapplication/sample.dart';
import 'package:flutter/material.dart';
import 'package:deapplication/splashscreen/splashscreen.dart';


class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  static List<bool> likeproducts = []; // true false
  static List<bool> cartproduts = [];
  static var likedata = [];


  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  int _currentIndex = 0;
  Myproduct123? myproduct123;
  List<Myproduct123> fijdata = [];
  final List<Widget> _pages = [
    homepage(),
    SearchScreen(),
    likeproductes(),
    ProfilePage(),
  ];
  int pageindex = 0;
  final List<Color> _iconColors = [
    Colors.black,
    Colors.black, // Search icon color
    Colors.black, // Like icon color
    Colors.black, // Profile icon color
  ];
  List itemname = [
    'All',
    'Doms',
    'doms1',
    'doms1',
    'doms1',
    'doms1',
  ];
  int showpic = 5;
  var viewproduct = [];
  var userdata = [];
  var SerachList = [];
  int countlike = 1;
  bool Isearch = false;
  // bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("${homepage.likedata}!!!!!!!!!!!!!!!!!!!");

    setState(() {
      homepage.likeproducts = List<bool>.filled(15, false);
      homepage.cartproduts = List<bool>.filled(15, false);
      print(homepage.likeproducts);
      print(homepage.cartproduts);
    });
    forviewproducthomepage();
    foruserdata();


    myproduct123 = Myproduct123.fromJson(jdata[0]);

    setState(() {
      for (int j = 0; j < jdata.length; j++) {
        String Id = "${jdata[j]['id']}";

        String Productname = "${jdata[j]['product_name']}";

        String Mrp = "${jdata[j]['MRP']}";

        String Conteactno = "${jdata[j]['contect_no.']}";

        String Description = "${jdata[j]['description']}";

        String Location = "${jdata[j]['location']}";

        String Pincode = "${jdata[j]['pincode']}";

        String URl = "${jdata[j]['url']}";

        String MInqut = "${jdata[j]['min_qut']}";

        String Actualprice = "${jdata[j]['actual_price']}";

        String rating = "${jdata[j]['rating']}";

        String Category = "${jdata[j]['category']}";
        bool like = false;
        // isloading = true;
        // String jsondataadd =
        //     "INSERT INTO productdata (ID,product_name,MRP,contect_no,description,location,pincode,url,min_qut,actual_price,rating,category) VALUES('$Id','$Productname','$Mrp','$Conteactno','$Description','$Location','$Pincode','$URl','$MInqut','$Actualprice','$rating','$Category')";
        //
        // print("${jsondataadd}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
        //
        // var a  = signin.db!.rawInsert(jsondataadd);

        MyDataBase().foraddjsondata(
            Id,
            Productname,
            Mrp,
            Conteactno,
            Description,
            Location,
            Pincode,
            URl,
            MInqut,
            Actualprice,
            rating,
            Category,
            like,
            signin.db!);
      }
    });
    for (int i = 0; i < jdata.length; i++) {
      Myproduct123 mp123 = Myproduct123.fromJson(jdata[i]);
      fijdata.add(mp123);
    }
  }

  int clickIndex = -1;
  TextEditingController search = TextEditingController();

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
                      return cartview();
                    },
                  ));
                },
                icon: Icon(
                  Icons.card_travel,
                ))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader( // <-- SEE HERE
                decoration: BoxDecoration(color: const Color(0xff764abc)),
                accountName: Text(
                  "${userdata[0]['NAME']}",
                  // "Pinkesh Darji",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  "${userdata[0]['EMAIL']}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: FlutterLogo(),
              ),

              ListTile(
                title: Text('Home'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return homepage();
                    },
                  ));
                  // Navigate to home screen
                },
              ),
              ListTile(
                title: Text(' Add Products'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ProductFormExample();
                    },
                  ));
                },
              ),
              ListTile(
                title: Text('Cart'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return cartview();
                    },
                  ));
                  // Navigate to cart screen
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  splashpage.prefe!.setBool("logininfo", false).then(
                        (value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return signin();
                        },
                      ));
                    },
                  );
                },
              ),
            ],
          ),
        ),

        bottomNavigationBar: Theme(
          data: ThemeData(canvasColor: Color(0xff62B6B7)),
          child: BottomNavigationBar(
            fixedColor: Colors.black,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _updateIconColors(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: InkWell(
                    onTap: () {
                      setState(() {
                        pageindex=0;
                      });
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return homepage();
                        },
                      ));
                    },
                    child: Icon(Icons.home, color: _iconColors[0])),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, color: _iconColors[1]),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: InkWell(
                    onTap: () {
                      setState(() {
                        pageindex=2;
                      });

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return likeproductes();
                        },
                      ));
                    },
                    child: Icon(Icons.favorite, color: _iconColors[2])),
                label: 'Like',
              ),
              BottomNavigationBarItem(
                icon: InkWell(
                    onTap: () {
                      setState(() {
                        pageindex=3;
                      });

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ProfilePage();
                        },
                      ));
                    },
                    child: Icon(Icons.person, color: _iconColors[3])),
                label: 'Profile',
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 80,
                      padding: EdgeInsets.all(10),
                      child: Center(
                          child: TextField(
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              SerachList = [];
                              for (int i = 0; i < viewproduct.length; i++) {
                                String productname =
                                    viewproduct[i]['product_name'];
                                String category = viewproduct[i]['category'];
                                if (productname
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    category
                                        .toLowerCase()
                                        .contains(value.toLowerCase())) {
                                  SerachList.add(viewproduct[i]);
                                }
                              }
                            } else {
                              SerachList = viewproduct;
                            }
                          });
                        },
                        controller: search,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff949494))),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  Isearch = !Isearch;
                                  SerachList = viewproduct;
                                });
                              },
                              icon: Icon(
                                Icons.search,
                                color: Color(0xff62B6B7),
                              )),
                          // Icon(Icons.search, color: Color(0xff62B6B7)),
                          label: Text("Search for Brand or product name..",
                              style: TextStyle(color: Color(0xff62B6B7))),
                          border: OutlineInputBorder(),
                          filled: true,
                        ),
                      )),

                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Container(
                  //     padding: EdgeInsets.all(10),
                  //     height: 80,
                  //     child: Container(
                  //         padding: EdgeInsets.all(7),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             border: Border.all(color: Color(0xff949494))),
                  //         child: Image.asset(
                  //           "Icon/option.png",
                  //           fit: BoxFit.fill,
                  //         )),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 100,
                      // color: Colors.cyan,
                      margin: EdgeInsets.all(10),
                      child: Text("New Arrival",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 100,

                      margin: EdgeInsets.all(10) + EdgeInsets.only(left: 5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showpic = viewproduct.length;
                          });
                        },
                        child: Text("See All",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,

                    itemCount: Isearch ? SerachList.length : viewproduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return productview(viewproduct[index]);
                            },
                          ));
                        },
                        child: Container(
                            color: Color(0xff9ad9da),
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              title: Isearch
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      child: Image.network(
                                          "${SerachList[index]['url']}"),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(10),
                                      child: Image.network(
                                          "${viewproduct[index]['url']}"),
                                    ),
                              subtitle: Isearch
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${SerachList[index]['product_name']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black)),
                                        Row(
                                          children: [
                                            Text(
                                                "₹${SerachList[index]['actual_price']}.00"),
                                            SizedBox(
                                              width: 230,
                                            ),
                                            IconButton(
                                                onPressed: () {

                                                  // setState(() {
                                                  //
                                                  //   countlike = countlike + 1;
                                                  //   print(
                                                  //       ("${homepage.likedata}##"));
                                                  //   print(
                                                  //       ("${homepage.likeproducts[index]}<<##>>"));
                                                  //   if (homepage
                                                  //       .likeproducts[index]) {
                                                  //     print('****************');
                                                  //
                                                  //   } else {
                                                  //     homepage.likedata.add(
                                                  //         viewproduct[index]);
                                                  //   }
                                                  //   homepage.likeproducts[
                                                  //           index] =
                                                  //       !homepage.likeproducts[
                                                  //           index];
                                                  //   print(
                                                  //       '::::::::::::::::::;; ${homepage.likedata.length}');
                                                  //   print(" like product ==>${homepage.likeproducts}");
                                                  // });
                                                },
                                                icon: homepage
                                                        .likeproducts[index]
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border))
                                          ],
                                        )
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${viewproduct[index]['product_name']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black)),
                                        Row(
                                          children: [
                                            Text(
                                                "₹${viewproduct[index]['actual_price']}.00"),
                                            SizedBox(
                                              width: 230,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    homepage.likeproducts[
                                                    index] =
                                                    !homepage.likeproducts[
                                                    index];
                                                    print("${homepage.likeproducts[index]}");


                                                    if(!homepage.likeproducts[index] == false)
                                                      {
                                                        MyDataBase().foraddlike(homepage.likeproducts[index],viewproduct[index]['product_name'],signin.db!);
                                                      }
                                                    else
                                                      {
                                                        MyDataBase().foraddlike(homepage.likeproducts[index],viewproduct[index]['product_name'],signin.db!);

                                                      }

                                                    print("likeproduct ==>${homepage.likeproducts}");
                                                  });
                                                },
                                                icon: homepage
                                                        .likeproducts[index]
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border))
                                          ],
                                        )
                                      ],
                                    ),
                            )),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateIconColors(int index) {
    for (int i = 0; i < _iconColors.length; i++) {
      _iconColors[i] = (i == index)
          ? Colors.blue
          : Colors.black; // Change the color of the selected icon
    }
  }



  void forviewproducthomepage() {
    MyDataBase().forviewproduct(signin.db!).then((value) {
      setState(() {
        viewproduct = value;
        SerachList = value;
      });
    });
  }

  void foruserdata() {
    MyDataBase().foruserdata(signin.db!).then((value) {
      setState(() {
        userdata = value;
        print("userdata ==>${userdata}");
      });

    });
  }


}

class Myproduct123 {
  int? id;
  String? productName;
  int? mRP;
  String? contectNo;
  String? description;
  String? location;
  String? pincode;
  String? url;
  int? minQut;
  int? actualPrice;
  var rating;
  String? category;

  Myproduct123(
      {this.id,
      this.productName,
      this.mRP,
      this.contectNo,
      this.description,
      this.location,
      this.pincode,
      this.url,
      this.minQut,
      this.actualPrice,
      this.rating,
      this.category});

  Myproduct123.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    mRP = json['MRP'];
    contectNo = json['contect_no.'];
    description = json['description'];
    location = json['location'];
    pincode = json['pincode'];
    url = json['url'];
    minQut = json['min_qut'];
    actualPrice = json['actual_price'];
    rating = json['rating'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['MRP'] = this.mRP;
    data['contect_no.'] = this.contectNo;
    data['description'] = this.description;
    data['location'] = this.location;
    data['pincode'] = this.pincode;
    data['url'] = this.url;
    data['min_qut'] = this.minQut;
    data['actual_price'] = this.actualPrice;
    data['rating'] = this.rating;
    data['category'] = this.category;
    return data;
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Screen'),
    );
  }
}

class LikeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Like Screen'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen'),
    );
  }
}

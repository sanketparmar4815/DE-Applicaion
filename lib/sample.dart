// import 'package:flutter/material.dart';
//
//
// class CartItem {
//   final String name;
//   final double price;
//   final int quantity;
//
//   CartItem({required this.name, required this.price, required this.quantity});
// }
//
// class CartScreen extends StatefulWidget {
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   List<CartItem> cartItems = [
//     CartItem(name: 'Product 1', price: 10.0, quantity: 2),
//     CartItem(name: 'Product 2', price: 15.0, quantity: 1),
//     CartItem(name: 'Product 3', price: 5.0, quantity: 3),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           final cartItem = cartItems[index];
//           return ListTile(
//             title: Text(cartItem.name),
//             subtitle: Text('Price: \$${cartItem.price}'),
//             trailing: Text('Quantity: ${cartItem.quantity}'),
//           );
//         },
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Total: \$${calculateTotal()}',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement checkout logic here
//               },
//               child: Text('Checkout'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   double calculateTotal() {
//     double total = 0;
//     for (var cartItem in cartItems) {
//       total += cartItem.price * cartItem.quantity;
//     }
//     return total;
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: CartScreen(),
//   ));
// }
import 'package:deapplication/database/Database.dart';
import 'package:deapplication/homepage/homepage.dart';
import 'package:deapplication/homepage/loginpage.dart';
import 'package:flutter/material.dart';

class ProductFormExample extends StatefulWidget {
  @override
  _ProductFormExampleState createState() => _ProductFormExampleState();
}

class _ProductFormExampleState extends State<ProductFormExample> {
  final _formKey = GlobalKey<FormState>();

  String _productName = '';
  double _mrp = 0.0;
  String _contactNumber = '';
  String _description = '';
  String _location = '';
  String _pincode = '';
  String _url = '';
  int _minQuantity = 0;
  double _actualPrice = 0.0;
  double _rating = 0.0;
  String _category = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Add Product ')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Product Name', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _productName = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'MRP', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the MRP';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _mrp = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 15,),

              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Contact Number', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _contactNumber = value;
                  });
                },
              ),
              SizedBox(height: 15,),

              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Description', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              SizedBox(height: 15,),

              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Location', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _location = value;
                  });
                },
              ),
              SizedBox(height: 15,),

              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Pincode', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a pincode';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _pincode = value;
                  });
                },
              ),
              SizedBox(height: 15,),

              TextFormField(
                decoration: InputDecoration(
                    labelText: 'URL', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _url = value;
                  });
                },
              ),
              SizedBox(height: 15,),

              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Minimum Quantity',
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the minimum quantity';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _minQuantity = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 15,),

              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Actual Price', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the actual price';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _actualPrice = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 15,),

              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Rating', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _rating = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 15,),

              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Category', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
              ),

              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the form data
                    // You can perform your desired action here
                    print('Form submitted');
                    print('Product Name: $_productName');
                    print('MRP: $_mrp');
                    print('Contact Number: $_contactNumber');
                    print('Description: $_description');
                    print('Location: $_location');
                    print('Pincode: $_pincode');
                    print('URL: $_url');
                    print('Minimum Quantity: $_minQuantity');
                    print('Actual Price: $_actualPrice');
                    print('Rating: $_rating');
                    print('Category: $_category');
                  }
                  MyDataBase()
                      .foraddproductdata(
                    _productName.toString(),
                    _mrp.toString(),
                    _contactNumber.toString(),
                    _description.toString(),
                    _location.toString(),
                    _pincode.toString(),
                    _url.toString(),
                    _minQuantity.toString(),
                    _actualPrice.toString(),
                    _rating.toString(),
                    _category.toString(),
                    signin.db!,
                  )
                      .then(
                    (value) {
                      _productName = '';
                      _mrp = 0.0;
                      _contactNumber = '';
                      _description = '';
                      _location = '';
                      _pincode = '';
                      _url = '';
                      _minQuantity = 0;
                      _actualPrice = 0.0;
                      _rating = 0.0;
                      _category = '';
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return homepage();
                        },
                      ));
                    },
                  );
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
// void main() {
//   runApp(MaterialApp(
//     home: ProductFormExample(),
//   ));
// }

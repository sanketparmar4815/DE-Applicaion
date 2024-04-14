import 'dart:convert';
import 'dart:io';
import 'package:deapplication/splashscreen/splashscreen.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart' as picker;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PickedFile? selectedImage;

  final _formKey = GlobalKey<FormState>();

  String _name = '';

  String _email = '';
  String _phoneNumber = '';
  DateTime? _dob;
  String imagepic = "";
  // Gender? _gender;

  String name = splashpage.prefe!.getString("getprofilename") ?? "Name";

  String email =splashpage.prefe!.getString("getprofileemail") ?? "xyz@gmail.com";
  double number = splashpage.prefe!.getDouble("getprofilenumber") ?? 0000;
  String dob = splashpage.prefe!.getString("getprofiledob") ?? "00/00/0000";
  String gender = splashpage.prefe!.getString("getprofilegender")?? " ";

TextEditingController namep = TextEditingController();
TextEditingController emailp = TextEditingController();
TextEditingController numberp = TextEditingController();
TextEditingController dobp = TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    namep.text = splashpage.prefe!.getString("getprofilename") ?? "Name";
    emailp.text =splashpage.prefe!.getString("getprofileemail") ?? "xyz@gmail.com";
    numberp.text =splashpage.prefe!.getString("getprofilenumber") ?? "0000";
    dobp.text =splashpage.prefe!.getString("getprofilegender") ?? " ";
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff060047),
                  ),

                  child: Center(
                      child: CircleAvatar(
                        maxRadius: 100,
                        backgroundColor: Color(0xff060047),
                        foregroundImage: selectedImage != null
                            ? FileImage(File(selectedImage!.path))
                            : null,

                      )),
                ),
                MaterialButton(
                  onPressed: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 200,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text("Pick Profile Picture",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: _getFromGallery,
                                      child: Container(
                                        height: 125,
                                        child: Image(
                                            image: AssetImage(
                                              "images/add_image.png",
                                            )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: _getFromCamera,
                                      child: Container(
                                        height: 125,
                                        child: Image(
                                            image: AssetImage(
                                              "images/camera.png",
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  height: 50,
                  shape: CircleBorder(),
                  child: Icon(Icons.edit),

                  color: Colors.white,
                ),
                TextFormField(

                  decoration: InputDecoration(labelText: 'Name',border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email Address',border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number',border: OutlineInputBorder()),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _phoneNumber = value;
                    });
                  },
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Date of Birth',border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date of birth';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Ignore changes since it's disabled
                      },
                      controller: TextEditingController(
                        text: _dob != null ? _dob!.toString() : '',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Gender',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: Text('Male'),
                  leading: Radio(
                    value: 'Male',
                    groupValue: Gender,
                    onChanged: (value) {
                      setState(() {
                        Gender = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Female'),
                  leading: Radio(
                    value: 'Female',
                    groupValue: Gender,
                    onChanged: (value) {
                      setState(() {
                        Gender = value!;
                      });
                    },
                  ),
                ),

                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the form data
                      // You can perform your desired action here
                      print('Form submitted');
                      print('Name: $_name');

                      print('Email Address: $_email');
                      print('Phone Number: $_phoneNumber');
                      print('Date of Birth: $_dob');
                      // print('Gender: $_gender');
                    }
                  },
                  child: InkWell(
                      onTap: () {


                        setState(() {
                          // List<int> imgbyte = File(selectedImage as String).readAsBytesSync();
                          // String imagedata = base64Encode(imgbyte);

                          splashpage.prefe!.setString("getprofilename", _name);
                          splashpage.prefe!.setString("profilepic", selectedImage.toString());
                          splashpage.prefe!.setString("getprofilegender", Gender);
                          splashpage.prefe!.setString("getprofileemail", _phoneNumber);
                          splashpage.prefe!.setString("getprofilenumber", _email);
                          splashpage.prefe!.setString("getprofiledob", _dob as String);
                        });
                      },child: Text('Submit')),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dob = picked;
      });
    }
  }
  Future<void> _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: picker.ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = pickedFile;
      });
    }
  }



  Future<void> _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: picker.ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = pickedFile;
      });
    }
  }
}
// enum Gender {
//   Male,
//   Female,
//   // Other,
// }
String Gender ="";
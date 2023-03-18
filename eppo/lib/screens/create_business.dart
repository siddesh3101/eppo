import 'dart:convert';
import 'dart:io';

import 'package:eppo/constants/colors.dart';
import 'package:eppo/pages/main_page.dart';
import 'package:eppo/theme/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/input_field.dart';
import 'location_screen.dart';
// import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  static const String id = '/register';

  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? demo;
  final List<String> _chips = [];
  final List<String> _skills = [];
  String selectedOption = "Saloon";

  List<String> options = ['Saloon', 'Hospital', 'Lawyer'];
  final List<String> _department = [];
  var exp = "";

  // Text Editing Controllers
  final TextEditingController _nameController = TextEditingController(text: "");

  final TextEditingController _emailController =
      TextEditingController(text: "");

  final TextEditingController _minAmountController =
      TextEditingController(text: "");

  final TextEditingController _addressController =
      TextEditingController(text: "");
  late bool toggle = true;

  // final TextEditingController _confirmPasswordController =
  // TextEditingController();

  File? file;

  void _addChip(String text) {
    setState(() {
      _chips.add(text);
    });
  }

  void _removeChip(String text) {
    setState(() {
      _chips.remove(text);
    });
  }

  void _addChipSkills(String text) {
    setState(() {
      _skills.add(text);
    });
  }

  void _removeChipSkills(String text) {
    setState(() {
      _skills.remove(text);
    });
  }

  void _addChipDepartment(String text) {
    setState(() {
      _department.add(text);
    });
  }

  void _removeChipDepartment(String text) {
    setState(() {
      _department.remove(text);
    });
  }

  void onPickImageButtonClicked() async {
    final tempImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (tempImage == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Failed to pick image!'),
      ));
      return;
    }

    setState(() {
      demo = File(tempImage.path);
    });
  }

  void onPickFileButtonClicked() async {
    FilePickerResult? tempImage = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (tempImage == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Failed to pick image!'),
      ));
      return;
    }

    setState(() {
      file = File(tempImage.files.single.path!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.withOpacity(0.4),
      appBar: AppBar(
        backgroundColor: Pallete.whiteColor,
        elevation: 1,
        title: Text(
          "Register your Business",
          style: TextStyle(color: Pallete.blackColor),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Pallete.whiteColor),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                            text: 'Business Name',
                            style: TextStyle(
                                color: Pallete.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(
                        controller: _nameController,
                        placeholderText: "Enter Business Name",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Address',
                            style: TextStyle(
                                color: Pallete.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(
                        controller: _addressController,
                        placeholderText: "Enter Full Address",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Users will see this address",
                        style: TextStyle(color: Pallete.greyColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Current  Location',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Pallete.greyColor),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const LocationScreen(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Email Id',
                            style: TextStyle(
                                color: Pallete.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(
                        controller: _emailController,
                        // exp: false,
                        placeholderText: "Enter your email address",
                        // onTap: () {
                        //   showAlertDialog(context);
                        // },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Category',
                            style: TextStyle(
                                color: Pallete.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedOption,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedOption = newValue!;
                              });
                            },
                            items: options.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'Minimum Appointment Booking Amount',
                            style: TextStyle(
                                color: Pallete.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ]),
                        textScaleFactor: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(
                        controller: _minAmountController,
                        // exp: false,
                        placeholderText: "Enter minimum amount",
                        textinput: TextInputType.number,

                        // onTap: () {
                        //   showAlertDialog(context);
                        // },
                      ),
                      // TextFormField(
                      //   controller: _hiringController,
                      //   decoration: InputDecoration(
                      //     hintText:
                      //         _chips.isNotEmpty ? "" : 'Enter hiring manager',
                      //     // labelText: "Enter hiring manager",
                      //     suffixIcon: IconButton(
                      //       icon: Icon(Icons.add),
                      //       onPressed: () {
                      //         String text = _hiringController.text.trim();
                      //         if (text.isNotEmpty) {
                      //           _addChip(text);
                      //           _hiringController.clear();
                      //         }
                      //       },
                      //     ),
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 8.0, horizontal: 16.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //       borderSide: BorderSide(
                      //         color: Colors.grey[400]!,
                      //         width: 1.0,
                      //       ),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //       borderSide: BorderSide(
                      //         color: Colors.blue,
                      //         width: 1.0,
                      //       ),
                      //     ),
                      //     prefixIcon: _chips.isNotEmpty
                      //         ? Padding(
                      //             padding: const EdgeInsets.only(left: 5),
                      //             child: Wrap(
                      //               spacing: 8.0,
                      //               runSpacing: 4.0,
                      //               children: _chips.map((chipText) {
                      //                 return Chip(
                      //                   label: Text(chipText),
                      //                   onDeleted: () => _removeChip(chipText),
                      //                 );
                      //               }).toList(),
                      //             ),
                      //           )
                      //         : null,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      // RichText(
                      //   text: const TextSpan(
                      //       text: 'Preferred Department/Function',
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 16),
                      //       children: [
                      //         TextSpan(
                      //             text: ' *',
                      //             style: TextStyle(
                      //                 color: Colors.red,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 12))
                      //       ]),
                      //   textScaleFactor: 1,
                      // ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      // TextFormField(
                      //   controller: _deptController,
                      //   decoration: InputDecoration(
                      //     hintText: _department.isNotEmpty
                      //         ? ""
                      //         : 'Maximum two functions can be selected',
                      //     // labelText: "Enter hiring manager",
                      //     suffixIcon: IconButton(
                      //       icon: Icon(Icons.add),
                      //       onPressed: () {
                      //         String text = _deptController.text.trim();
                      //         if (text.isNotEmpty) {
                      //           _addChipDepartment(text);
                      //           _deptController.clear();
                      //         }
                      //       },
                      //     ),
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 8.0, horizontal: 8.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //       borderSide: BorderSide(
                      //         color: Colors.grey[400]!,
                      //         width: 1.0,
                      //       ),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //       borderSide: BorderSide(
                      //         color: Colors.blue,
                      //         width: 1.0,
                      //       ),
                      //     ),
                      //     prefixIcon: _department.isNotEmpty
                      //         ? Padding(
                      //             padding: const EdgeInsets.only(left: 5),
                      //             child: Wrap(
                      //               spacing: 8.0,
                      //               runSpacing: 4.0,
                      //               children: _department.map((chipText) {
                      //                 return Chip(
                      //                   label: Text(chipText),
                      //                   onDeleted: () =>
                      //                       _removeChipDepartment(chipText),
                      //                 );
                      //               }).toList(),
                      //             ),
                      //           )
                      //         : null,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Pallete.whiteColor),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 300,
                          height: 60,
                          child: ElevatedButton.icon(
                              onPressed: () async {
                                // onPickImageButtonClicked();
                                onPickFileButtonClicked();
                              },
                              icon: file != null
                                  ? const Icon(
                                      Icons.done,
                                      color: MyColors.primaryColor,
                                    )
                                  : const Icon(
                                      Icons.upload,
                                      color: MyColors.primaryColor,
                                    ),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 229, 239, 254)),
                              ),
                              label: Text(
                                file != null ? "Uploaded" : "Upload Image",
                                style: TextStyle(color: MyColors.primaryColor),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Doc, PDF(Max file size- 6MB)",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Business with images are 3x more likely to be\nnoticed by users.",
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Pallete.whiteColor),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Switch.adaptive(
                          thumbColor:
                              MaterialStateProperty.all(MyColors.primaryColor),
                          activeTrackColor: Colors.blueAccent.withOpacity(0.6),
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.grey,
                          value: toggle,
                          onChanged: (value) {
                            setState(() {
                              toggle = value;
                            });
                          }),
                      const Text("I want to receive updates on "),
                      Image.asset(
                        "assets/whatsapp.png",
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      const Text("whatsapp")
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Pallete.whiteColor),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                          "By Registering, you agree to our Terms and Conditions,\nPrivacy Policy and default mailer and communictions\nsettings governing the use of appy.in"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Pallete.whiteColor),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ));
                              // final status = await UserStore().register(
                              //     email: _emailController.text,
                              //     lat: 46.22,
                              //     lon: 34.22,
                              //     macId: "2344554",
                              //     password1: _passwordController.text,
                              //     password2: _confirmPasswordController.text,
                              //     resume: file,
                              //     preferredDepartment: "It/Software",
                              //     domainPreference: "Software Developement",
                              //     username: "Sid@31");
                              // if (status) {
                              //   print("done");
                              //   Navigator.popAndPushNamed(
                              //       context, SplashScreen.id);
                              // }
                              // Navigator.popAndPushNamed(
                              //     context, SplashScreen.id);
                              // // print("pressed");
                              // // if (demo != null) {
                              // //   var request = http.MultipartRequest(
                              // //       'POST',
                              // //       Uri.parse(
                              // //           'https://innovative-minds.mustansirg.in/api/companies/'));

                              // //   request.files.add(
                              // //       await http.MultipartFile.fromPath(
                              // //           'headquarters', demo!.path));
                              // //   request.files.add(
                              // //       await http.MultipartFile.fromPath(
                              // //           'logo', demo!.path));
                              // //   request.fields.addAll(
                              // //       {'name': 'Amazon', 'admins': '1'});
                              // //   var response = await request.send();
                              // //   await http.Response.fromStream(response)
                              // //       .then((value) {
                              // //     var body = jsonDecode(value.body);
                              // //   });
                              // // }
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  MyColors.primaryColor),
                            ),
                            child: const Text(
                              "Save and Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

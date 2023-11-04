import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sb_diagnostics/entry_point.dart';
import 'package:sb_diagnostics/models/user_model.dart';

import '../../firebase_stuff/profile_controller.dart';
import '/constants.dart';
import 'components/all_fields.dart';

import 'components/edit_user_card.dart';
import '/components/custom_app_bar.dart';
import 'components/gender_check_box.dart';
import 'components/user_button.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.dob,
      required this.gender,
      required this.phoneNo,
      required this.email,
      required this.id})
      : super(key: key);
  final String? id;
  final String firstName;
  final String lastName;
  final String dob;
  final String gender;
  final String phoneNo;
  final String email;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final FocusNode _firstNameNode = FocusNode();
  final FocusNode _lastNameNode = FocusNode();
  final FocusNode _dateNode = FocusNode();

  bool isMale = true;
  bool isMaleValueSet = false;
  bool isMaleError = false;
  bool isDateSet = false;
  bool isLastNameSet = false;

  final profileController = Get.put(ProfileController());
  // final signUpController = Get.put(SignUpController());

  @override
  void initState() {
    super.initState();
    isMaleValueSet = widget.gender != "";
    isMale = widget.gender == "" || widget.gender == "Male";
    isLastNameSet = widget.lastName != "";
    if (widget.dob != "") {
      _dateController.text = widget.dob;
    }
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppbar(heading: "Edit Details"),
              const EditUserImage(),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: medPadding,
                    vertical: smallPadding,
                  ),
                  child: Column(
                    children: [
                      FirstNameField(
                        firstNameNode: _firstNameNode,
                        firstNameController: _firstNameController,
                        initialValue: widget.firstName,
                      ),
                      LastNameField(
                        lastNameNode: _lastNameNode,
                        lastNameController: _lastNameController,
                        initialValue: widget.lastName,
                      ),
                      DOBField(
                        dateNode: _dateNode,
                        dateController: _dateController,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: widget.dob != "" ? DateFormat('dd/MM/yyyy').parse(widget.dob) : DateTime.now(),
                            firstDate: DateTime(1930),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: pinkPurple,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.blueAccent,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: pinkPurple,
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (pickedDate != null) {
                            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                            setState(() {
                              _dateController.text = formattedDate; //set output date to TextField value.
                            });
                          }
                        },
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              top: smallPadding,
                              bottom: smallPadding,
                            ),
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GenderCheckBox(
                                label: "Male",
                                isMale: isMale,
                                isMaleValueSet: isMaleValueSet,
                                ontap: () {
                                  setState(
                                    () {
                                      isMaleValueSet = true;
                                      isMale = true;
                                    },
                                  );
                                },
                              ),
                              GenderCheckBox(
                                label: "Female",
                                isMale: !isMale,
                                isMaleValueSet: isMaleValueSet,
                                ontap: () {
                                  setState(
                                    () {
                                      isMaleValueSet = true;
                                      isMale = false;
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                          if (isMaleError)
                            Padding(
                              padding: const EdgeInsets.only(top: smallPadding),
                              child: Text(
                                "Please choose a gender",
                                style: TextStyle(
                                  color: Colors.red[600],
                                ),
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              UserButton(
                color: pinkPurple,
                icon: const Icon(Icons.edit),
                label: "Edit Details",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (!isMaleValueSet) {
                      setState(() {
                        isMaleError = true;
                      });
                      return;
                    } else {
                      setState(() {
                        isMaleError = false;
                      });
                      String isMaleLabel;
                      if (isMale) {
                        isMaleLabel = "Male";
                      } else {
                        isMaleLabel = "Female";
                      }
                      UserModel userData = UserModel(
                        id: widget.id,
                        firstName: _firstNameController.text.trim(),
                        lastName: _lastNameController.text.trim(),
                        phoneNo: widget.phoneNo,
                        dob: _dateController.text,
                        gender: isMaleLabel,
                        email: widget.email,
                      );
                      setState(() {
                        _isLoading = true;
                      });
                      await profileController.updateRecord(userData);
                      profileController.valuesChanged();
                      setState(() {
                        _isLoading = false;
                      });
                      Get.offAll(() => const EntryPoint(
                            selectedNav: 3,
                          ));
                    }
                  }
                },
              ),
              if (_isLoading) const CircularProgressIndicator(color: darkPurple)
            ],
          ),
        ),
      ),
    );
  }
}

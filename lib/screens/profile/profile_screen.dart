import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sb_diagnostics/components/general_error_page.dart';
import 'package:sb_diagnostics/firebase_stuff/profile_controller.dart';
import 'package:sb_diagnostics/models/user_model.dart';

import '../contact/contact_screen.dart';
import '/firebase_stuff/auth_repo.dart';
import 'components/user_button.dart';
import 'components/user_card.dart';
import '/components/heading.dart';
import '/constants.dart';
import 'components/user_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double width(context) {
    return MediaQuery.of(context).size.width - 2 * medPadding;
  }

  final profileController = Get.put(ProfileController());
  bool areValuesSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Heading(text: "Profile"),
              FutureBuilder(
                future: profileController.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      String firstName = userData.firstName;
                      String lastName = userData.lastName;
                      String phoneNo = userData.phoneNo;
                      String dob = userData.dob;
                      String gender = userData.gender;
                      String email = userData.email;
                      if (dob != "" && gender != '') {
                        areValuesSet = true;
                      }
                      if (email == "guest@gmail.com") {
                        return Column(
                          children: [
                            UserCard(name: "$firstName $lastName"),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: medPadding),
                              child: Text(
                                "Please login to view and edit your account details. \n You will be texted your user name and password when your register at the lab.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, color: blueGrey),
                              ),
                            )
                          ],
                        );
                      }
                      return Column(
                        children: [
                          UserCard(name: "$firstName $lastName"),
                          UserField(label: "Phone", text: phoneNo),
                          UserField(label: "Username", text: email.substring(0, email.length - 10)),
                          UserField(label: "DOB", text: dob == "" ? "Not set" : dob),
                          UserField(label: "Gender", text: gender == "" ? "Not set" : gender),
                          if (!areValuesSet)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: medPadding),
                              child: FittedBox(
                                child: Text(
                                  "Note: Please add your details by clicking the button below.",
                                  style: TextStyle(color: Colors.red[600]),
                                ),
                              ),
                            ),
                          // UserButton(
                          //   color: darkPurple,
                          //   icon: const Icon(Icons.edit),
                          //   label: "Edit Details",
                          //   onPressed: () => Get.to(
                          //     () => ProfileEditScreen(
                          //       email: email,
                          //       id: userData.id,
                          //       firstName: firstName,
                          //       dob: dob,
                          //       lastName: lastName,
                          //       gender: gender,
                          //       phoneNo: phoneNo,
                          //     ),
                          //   ),
                          // ),
                          UserButton(
                            color: lightPurple,
                            icon: const Icon(Icons.contact_support),
                            label: "Contact Us",
                            onPressed: () => Get.to(() => const ContactScreen()),
                          ),
                          UserButton(
                            color: pinkPurple,
                            icon: const Icon(Icons.arrow_back),
                            label: "Sign Out",
                            onPressed: () => AuthRepo.instance.logout(),
                          ),
                          if (MediaQuery.of(context).size.height < 900) SizedBox(height: 960 - MediaQuery.of(context).size.height),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return GeneralErrorPage(errorString: snapshot.error.toString());
                    } else {
                      return const GeneralErrorPage();
                    }
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        const Center(
                          child: CircularProgressIndicator(color: darkPurple),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

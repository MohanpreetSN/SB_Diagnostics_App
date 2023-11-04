import 'package:flutter/material.dart';

import '/constants.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: smallPadding,
        bottom: smallPadding,
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Name is required";
          }
          return null;
        },
        onSaved: (password) {},
        decoration: const InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: smallPadding),
            child: Icon(
              Icons.person,
              color: lightPurple,
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: smallPadding,
        bottom: smallPadding,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        validator: (value) {
          if (value!.isEmpty) {
            return "Name is required";
          }
          return null;
        },
        onSaved: (password) {},
        decoration: const InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: smallPadding),
            child: Icon(
              Icons.lock,
              color: lightPurple,
            ),
          ),
        ),
      ),
    );
  }
}

// class NameTextField extends StatelessWidget {
//   const NameTextField({
//     Key? key,
//     required this.scontroller,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: smallPadding,
//         bottom: smallPadding,
//       ),
//       child: TextFormField(
//         controller: scontroller.name,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return "Name is required";
//           }
//           return null;
//         },
//         onSaved: (password) {},
//         decoration: const InputDecoration(
//           prefixIcon: Padding(
//             padding: EdgeInsets.symmetric(horizontal: smallPadding),
//             child: Icon(
//               Icons.person,
//               color: lightPurple,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PhoneTextField extends StatelessWidget {
//   const PhoneTextField({
//     Key? key,
//     required this.scontroller,
//   }) : super(key: key);

//   final SignUpController scontroller;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: smallPadding,
//         //bottom: smallPadding,
//       ),
//       child: IntlPhoneField(
//         initialCountryCode: "IN",
//         //initialCountryCode: "CA",
//         controller: scontroller.phoneNum,
//         countries: const ["IN", "CA", "US"],
//         keyboardType: TextInputType.phone,
//         autovalidateMode: AutovalidateMode.disabled,
//         onChanged: (phone) {
//           scontroller.fullNum = phone.completeNumber;
//         },
//         validator: (phoneNumber) {
//           RegExp regex = RegExp(r'[0-9]{10}$');
//           if (phoneNumber!.number.isEmpty) {
//             return "Phone Number is required";
//           }
//           if (regex.hasMatch(phoneNumber.number)) {
//             return "Please enter a valid number";
//           }

//           return null;
//         },
//       ),
//     );
//   }
// }

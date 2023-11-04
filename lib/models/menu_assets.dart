import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

class MenuAsset {
  final Widget icon;
  final String title;
  final int index;

  MenuAsset(this.icon, this.title, this.index);
}

List<Widget> bottomNavs = [
  Image.asset("assets/icons/home-page.png"),
  Image.asset("assets/icons/acid-flask2.png"),
  Image.asset("assets/icons/clipboard.png"),
  Image.asset("assets/icons/user.png"),
];

List<MenuAsset> sideMenu = [
  MenuAsset(Image.asset("assets/icons/home-page.png"), "Home", 0),
  MenuAsset(Image.asset("assets/icons/acid-flask2.png"), "Tests", 1),
  MenuAsset(Image.asset("assets/icons/clipboard.png"), "Reports", 2),
  MenuAsset(Image.asset("assets/icons/user.png"), "Profile", 3),
  MenuAsset(
      const Icon(
        Icons.contact_support,
        color: Colors.white,
        size: 30,
      ),
      "Contact Us",
      4),
];

// List<RiveAsset> bottomNavs2 = [
//   RiveAsset("assets/RiveAssets/icons.riv",
//       artboard: "SEARCH",
//       stateMachineName: "SEARCH_Interactivity",
//       title: "Search"),
//   RiveAsset(
//     "assets/RiveAssets/icons.riv",
//     artboard: "CHAT",
//     stateMachineName: "CHAT_Interactivity",
//     title: "Chat",
//   ),
//   RiveAsset("assets/RiveAssets/icons.riv",
//       artboard: "TIMER",
//       stateMachineName: "TIMER_Interactivity",
//       title: "Appointment"),
//   RiveAsset("assets/RiveAssets/icons.riv",
//       artboard: "USER",
//       stateMachineName: "USER_Interactivity",
//       title: "Profile"),
// ];

// List<RiveAsset> sideMenus = [
//   RiveAsset(
//     "assets/RiveAssets/icons.riv",
//     artboard: "HOME",
//     stateMachineName: "HOME_interactivity",
//     title: "Home",
//   ),
//   RiveAsset(
//     "assets/RiveAssets/icons.riv",
//     artboard: "SEARCH",
//     stateMachineName: "SEARCH_Interactivity",
//     title: "Search",
//   ),
//   RiveAsset(
//     "assets/RiveAssets/icons.riv",
//     artboard: "LIKE/STAR",
//     stateMachineName: "STAR_Interactivity",
//     title: "Favorites",
//   ),
//   RiveAsset(
//     "assets/RiveAssets/icons.riv",
//     artboard: "CHAT",
//     stateMachineName: "CHAT_Interactivity",
//     title: "Help",
//   ),
// ];

// List<RiveAsset> sideMenus2 = [
//   RiveAsset(
//     "assets/RiveAssets/icons.riv",
//     artboard: "TIMER",
//     stateMachineName: "TIMER_Interactivity",
//     title: "History",
//   ),
//   RiveAsset(
//     "assets/RiveAssets/icons.riv",
//     artboard: "BELL",
//     stateMachineName: "BELL_Interactivity",
//     title: "Notification",
//   ),
// ];

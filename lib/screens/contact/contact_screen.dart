import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '/components/custom_app_bar.dart';
import 'components/contact_icon_text.dart';
import 'components/map_open_button.dart';
import 'components/map_widget.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  void _mapOpenFunciton() async {
    var url = Uri.parse("https://goo.gl/maps/qBqG6z83Fdr6ZzE66");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _launchCaller() async {
    //var url = Uri.parse("tel:+917317700500");
    var url = Uri(scheme: 'tel', path: '7317700500');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchMail() async {
    //var url = Uri.parse("tel:+917317700500");
    var url = Uri(scheme: 'mailto', path: 'contact@sbdiagnostic.com');
    await launchUrl(url);
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppbar(heading: "Contact Us"),
              const MapWidget(),
              MapOpenButton(
                onTap: _mapOpenFunciton,
              ),
              ContactIconText(
                icon: Icons.location_on,
                text: "CP 198,Viraj Khand, Behind Singapore Mall, Near Haniman Chauraha, Gomti Nagar Lucknow, UP, 226010",
                onTap: _mapOpenFunciton,
              ),
              ContactIconText(
                icon: Icons.phone,
                text: "7317700500, 7054421333, 5224237771 Helpline no: 7510000521, 2, 3, 4",
                onTap: _launchCaller,
              ),
              ContactIconText(
                icon: Icons.email,
                text: "contact@sbdiagnostic.com",
                onTap: _launchMail,
              )
            ],
          ),
        ),
      ),
    );
  }
}

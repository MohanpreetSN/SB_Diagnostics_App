import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sb_diagnostics/firebase_stuff/report_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';
import '../../../models/report_model.dart';
import 'glass_morph.dart';

class ReportCard extends StatelessWidget {
  ReportCard({
    Key? key,
    required this.report,
  }) : super(key: key);

  final ReportModel report;
  final rController = Get.put(ReportRepo());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: medPadding, right: medPadding, top: medPadding),
      child: Stack(
        children: [
          Container(
            height: 98,
            width: MediaQuery.of(context).size.width - 2 * medPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage("assets/Backgrounds/smallTriangleLight.png"),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  //color: pinkPurple.withOpacity(0.5),
                  offset: Offset(1, 1),
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                ), //BoxShadow
              ],
            ),
          ),
          GlassMorph(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            height: 36,
            width: (MediaQuery.of(context).size.width - 2 * medPadding) * 0.75,
            sigma: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: medPadding),
              child: SmallCardTitle(title: report.testName),
            ),
          ),
          Positioned(
            top: medPadding,
            right: medPadding,
            child: GestureDetector(
              onTap: () async {
                var url = Uri.parse(report.downloadUrl);
                if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: GlassMorph(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                height: 62,
                width: 62,
                sigma: 10,
                child: Container(
                  //padding: const EdgeInsets.only(top: smallPadding),
                  alignment: Alignment.center,
                  child: const Center(
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: medPadding,
            top: 36 + smallPadding,
            child: SizedBox(
                width: (MediaQuery.of(context).size.width - 2 * medPadding) * 0.7 - smallPadding,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${report.firstName} ${report.lastName}',
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: smallPadding / 2,
                    ),
                    Text(
                      'Date: ${report.date}',
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class SmallCardTitle extends StatelessWidget {
  const SmallCardTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: smallPadding),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

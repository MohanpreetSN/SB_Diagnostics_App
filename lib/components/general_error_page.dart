import 'package:flutter/material.dart';
import 'package:sb_diagnostics/constants.dart';

class GeneralErrorPage extends StatelessWidget {
  const GeneralErrorPage({
    super.key,
    this.errorString = "",
  });

  final String errorString;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: medPadding),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Icon(
                  Icons.error,
                  color: darkPurple,
                  size: MediaQuery.of(context).size.width * 0.5,
                ),
                const SizedBox(
                  height: medPadding,
                ),
                const Text(
                  "Oops! Something went wrong, please try again soon.\n Contact us if the issue doesn't resolve soon.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: blueGrey),
                ),
                Text(
                  errorString,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: blueGrey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tiaraamarta_mobile/shared/theme.dart';
import 'package:tiaraamarta_mobile/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailRoomPage extends StatelessWidget {
  const DetailRoomPage(
      {super.key,
      required this.name,
      required this.desc,
      required this.link,
      required this.price});
  final String link;
  final String name;
  final int price;
  final String desc;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _launchUrl(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 32,
                  color: primaryColor,
                ),
              ),
              Text(
                "Detail Room",
                style: primaryColorText.copyWith(fontSize: 32),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/roomex.jpg"), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(defaultRadius)),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            name,
            style: darkText.copyWith(fontSize: 24, fontWeight: bold),
          ),
          Text(
            "Price : $price",
            style: darkText.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            desc,
            style: darkText.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              radiusButton: defaultRadius,
              buttonColor: primaryColor,
              buttonText: "Room Tour Video",
              widthButton: double.infinity,
              onPressed: () async {
                await _launchUrl(Uri.parse(link));
              },
              heightButton: 44)
        ],
      )),
    );
  }
}

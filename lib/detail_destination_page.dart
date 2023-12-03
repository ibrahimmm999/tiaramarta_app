import 'package:flutter/material.dart';
import 'package:tiaraamarta_mobile/models/ayokebali_model.dart';
import 'package:tiaraamarta_mobile/shared/theme.dart';
import 'package:tiaraamarta_mobile/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailDestinationPage extends StatelessWidget {
  const DetailDestinationPage({super.key, required this.ayoKeBaliModel});
  final AyoKeBaliModel ayoKeBaliModel;

  @override
  Widget build(BuildContext context) {
    const String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=";
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
                image: DecorationImage(
                    image: AssetImage(
                        (ayoKeBaliModel.category == "Restaurant" ||
                                ayoKeBaliModel.category == "Cafe")
                            ? "assets/food.jpg"
                            : (ayoKeBaliModel.category == "Pantai"
                                ? "assets/beach.jpg"
                                : (ayoKeBaliModel.category.contains("Club")
                                    ? "assets/club.jpg"
                                    : (ayoKeBaliModel.category == "Waterbom"
                                        ? "assets/waterbom.jpg"
                                        : (ayoKeBaliModel.category == "Mall"
                                            ? "assets/mall.jpg"
                                            : (ayoKeBaliModel.category ==
                                                    "Adventure"
                                                ? "assets/adv.jpg"
                                                : "assets/bali.jpg")))))),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(defaultRadius)),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            ayoKeBaliModel.name,
            style: darkText.copyWith(fontSize: 24, fontWeight: bold),
          ),
          Text(
            "Perkiraan Biaya : ${ayoKeBaliModel.price}",
            style: darkText.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Kategori : ${ayoKeBaliModel.category}",
            style: darkText.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Lokasi : ${ayoKeBaliModel.location}",
            style: darkText.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              radiusButton: defaultRadius,
              buttonColor: primaryColor,
              buttonText: "Direction",
              widthButton: double.infinity,
              onPressed: () async {
                await _launchUrl(Uri.parse(
                    "$googleMapsUrl${ayoKeBaliModel.latitude},${ayoKeBaliModel.longitude}"));
              },
              heightButton: 44)
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiaraamarta_mobile/detail_destination_page.dart';
import 'package:tiaraamarta_mobile/models/ayokebali_model.dart';
import 'package:tiaraamarta_mobile/providers/ayokebali_provider.dart';
import 'package:tiaraamarta_mobile/shared/theme.dart';

class AllDestinationPage extends StatelessWidget {
  const AllDestinationPage({super.key});
  @override
  Widget build(BuildContext context) {
    AyoKeBaliProvider ayoKeBaliProvider =
        Provider.of<AyoKeBaliProvider>(context);

    Widget cardDestination(AyoKeBaliModel ayoKeBaliModel) {
      return Container(
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
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
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ayoKeBaliModel.name,
                    overflow: TextOverflow.ellipsis,
                    style: whiteText.copyWith(fontSize: 16),
                  ),
                  Text(
                    "${ayoKeBaliModel.price} Rupiah",
                    style: whiteText.copyWith(fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ),
      );
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
                  "All Destination",
                  style: primaryColorText.copyWith(fontSize: 32),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Column(
              children: ayoKeBaliProvider.destinations.map((dest) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailDestinationPage(
                                    ayoKeBaliModel: dest,
                                  )));
                    },
                    child: cardDestination(dest));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

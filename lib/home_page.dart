import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiaraamarta_mobile/admin/input_room_page.dart';
import 'package:tiaraamarta_mobile/detail_room_page.dart';
import 'package:tiaraamarta_mobile/profile_page.dart';
import 'package:tiaraamarta_mobile/providers/room_provider.dart';
import 'package:tiaraamarta_mobile/providers/user_provider.dart';
import 'package:tiaraamarta_mobile/shared/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    RoomProvider roomProvider =
        Provider.of<RoomProvider>(context, listen: false);
    await roomProvider.getDataRooms(userProvider.user.token);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    RoomProvider roomProvider = Provider.of<RoomProvider>(context);
    Widget card(String name, int price) {
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
                  image: const DecorationImage(
                      image: AssetImage("assets/roomex.jpg"),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: whiteText.copyWith(fontSize: 20),
                ),
                Text(
                  "$price Rupiah",
                  style: whiteText.copyWith(fontSize: 16),
                )
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      floatingActionButton: Visibility(
        visible: userProvider.user.role != 'user',
        child: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InputRoomPage(
                            isEdit: false,
                          )));
            },
            child: const Icon(Icons.add)),
      ),
      body: SafeArea(
        child: ListView(padding: EdgeInsets.all(defaultMargin), children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 32,
                ),
              )
            ],
          ),
          Text(
            "Halo,",
            style: primaryColorText.copyWith(fontSize: 32, fontWeight: bold),
          ),
          Text(
            userProvider.user.fullname,
            style: secondaryColorText.copyWith(fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: userProvider.user.role == "user",
            child: Text(
              "Your Room",
              style: darkText.copyWith(fontSize: 20),
            ),
          ),
          Visibility(
            visible: userProvider.user.role == "user",
            child: Column(
              children: roomProvider.listRoom
                  .where((element) => element.user == userProvider.user.id)
                  .map((room) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailRoomPage(
                                  name: room.name,
                                  desc: room.desc,
                                  link: room.linkVideo,
                                  price: room.price)));
                    },
                    child: card(room.name, room.price));
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "All Room",
            style: darkText.copyWith(fontSize: 20),
          ),
          Column(
            children: roomProvider.listRoom.map((room) {
              return GestureDetector(
                  onTap: () {
                    userProvider.user.role == "user"
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailRoomPage(
                                    name: room.name,
                                    desc: room.desc,
                                    link: room.linkVideo,
                                    price: room.price)))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InputRoomPage(
                                      id: room.id,
                                      isEdit: true,
                                      name: room.name,
                                      desc: room.desc,
                                      link: room.linkVideo,
                                      price: room.price,
                                      user: room.user.toString(),
                                    )));
                  },
                  child: card(room.name, room.price));
            }).toList(),
          )
        ]),
      ),
    );
  }
}

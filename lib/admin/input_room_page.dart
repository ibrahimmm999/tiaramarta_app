import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiaraamarta_mobile/home_page.dart';
import 'package:tiaraamarta_mobile/services/room_service.dart';
import 'package:tiaraamarta_mobile/shared/theme.dart';
import 'package:tiaraamarta_mobile/widgets/custom_button.dart';
import 'package:tiaraamarta_mobile/widgets/custom_text_form_field.dart';

import '../providers/room_provider.dart';

class InputRoomPage extends StatefulWidget {
  const InputRoomPage(
      {super.key,
      this.name,
      this.id,
      this.desc,
      this.user,
      this.link,
      this.price,
      required this.isEdit});
  final String? link;
  final String? name;
  final int? price;
  final int? id;
  final String? desc;
  final String? user;
  final bool isEdit;

  @override
  State<InputRoomPage> createState() => _InputRoomPageState();
}

class _InputRoomPageState extends State<InputRoomPage> {
  @override
  Widget build(BuildContext context) {
    RoomProvider roomProvider = Provider.of<RoomProvider>(context);
    final TextEditingController linkC =
        TextEditingController(text: widget.link ?? "");
    final TextEditingController nameC =
        TextEditingController(text: widget.name ?? "");
    final TextEditingController priceC = TextEditingController(
        text: widget.price != null ? widget.price.toString() : "");
    final TextEditingController descC =
        TextEditingController(text: widget.desc ?? "");
    final TextEditingController usernameC =
        TextEditingController(text: widget.user ?? "");
    Widget inputName() {
      return CustomTextFormField(
        hintText: 'Room Name',
        controller: nameC,
        radiusBorder: defaultRadius,
      );
    }

    Widget inputLink() {
      return CustomTextFormField(
        hintText: 'Link Video',
        controller: linkC,
        radiusBorder: defaultRadius,
      );
    }

    Widget inputDesc() {
      return CustomTextFormField(
        hintText: 'Description',
        controller: descC,
        radiusBorder: defaultRadius,
      );
    }

    Widget inputPrice() {
      return CustomTextFormField(
        hintText: 'Price',
        controller: priceC,
        radiusBorder: defaultRadius,
        keyboardType: TextInputType.number,
      );
    }

    Widget inputUser() {
      return CustomTextFormField(
        hintText: 'Username',
        controller: usernameC,
        radiusBorder: defaultRadius,
        keyboardType: TextInputType.number,
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
                widget.isEdit ? "Edit Room" : "Add Room",
                style: primaryColorText.copyWith(fontSize: 32),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            "Room Name",
            style: darkText.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          inputName(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Price",
            style: darkText.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          inputPrice(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Description",
            style: darkText.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          inputDesc(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Link Video",
            style: darkText.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          inputLink(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "User ID",
            style: darkText.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          inputUser(),
          const SizedBox(
            height: 44,
          ),
          CustomButton(
              radiusButton: defaultRadius,
              buttonColor: primaryColor,
              buttonText: "Save",
              widthButton: double.infinity,
              onPressed: () async {
                widget.isEdit
                    ? await RoomService().editRoom(
                        id: widget.id!,
                        name: nameC.text,
                        price: priceC.text,
                        desc: descC.text,
                        urlVideo: linkC.text,
                        userId: usernameC.text)
                    : await RoomService().postRoom(
                        id: (roomProvider.listRoom.length + 1),
                        name: nameC.text,
                        price: priceC.text,
                        desc: descC.text,
                        urlVideo: linkC.text,
                      );
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false);
              },
              heightButton: 44),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: widget.isEdit,
            child: CustomButton(
                radiusButton: defaultRadius,
                buttonColor: Colors.red,
                buttonText: "Delete",
                widthButton: double.infinity,
                onPressed: () async {
                  await RoomService().deleteRoom(id: widget.id!);
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false);
                },
                heightButton: 44),
          ),
        ],
      )),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:chat_app/core/api_method/api.dart';
import 'package:chat_app/core/models/chat_model.dart';
import 'package:chat_app/core/utils/chat_card.dart';
import 'package:chat_app/core/utils/custom_text.dart';
import 'package:chat_app/core/utils/sizebox.dart';
import 'package:chat_app/feature/profile_screen/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/provider/state_manage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ModelChat> chat = [];

  @override
  void initState() {
    super.initState();
    Api.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PoviderState>(context, listen: true);
    return WillPopScope(
      onWillPop: () {
        return provider.function();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.home),
            title: provider.isSearching
                ? TextField(
                    decoration:const  InputDecoration(
                      border: InputBorder.none,
                      hintText: "Seach",
                    ),
                    autofocus: true,
                    onChanged: (value) {
                      provider.seachingList(chat, value);
                    },
                  )
                : CustomText(name: "Chat App"),
            centerTitle: true,
            actions: [
              InkWell(
                  onTap: () {
                    provider.searching();
                  },
                  child: const Icon(Icons.search)),
              10.w.pw,
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ProfileScreen(
                          chat: Api.profileData,
                        );
                      },
                    ));
                  },
                  child: const Icon(Icons.more_vert)),
              10.w.pw,
            ],
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: Api.getUser(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        CircularProgressIndicator()
                      ])); // Show a loading indicator while data is being fetched.
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text(
                      "No data available."); // Handle the case where there is no data.
                } else if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    // chat.clear();
                    final data = snapshot.data!.docs;
                    for (var i in data) {
                      final messageData = i.data() as Map<String, dynamic>;
                      chat.add(ModelChat.fromJson(messageData));
                    }

                    return ListView.builder(
                      itemCount: provider.isSearching
                          ? provider.serachList.length
                          : chat.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatCard(
                          chat: provider.isSearching
                              ? provider.serachList[index]
                              : chat[index],
                        );
                      },
                    );
                  }
                }
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Some thing  Error"),
                    ],
                  ),
                );
              })),
    );
  }
}

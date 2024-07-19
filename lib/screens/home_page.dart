import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_automation/services/apidata.dart';
import 'package:home_automation/screens/appliance_details_page.dart';
import 'package:home_automation/widgets/appliances_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: firestore
                    .collection('user')
                    .doc(auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.hasData) {
                    final data = snapshot.data!.data();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data != null
                                  ? 'Hello ${data['name']},'
                                  : 'Hello,',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Welcome to your smart home',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: data != null
                              ? CachedNetworkImageProvider(data['imageUrl'])
                              : const AssetImage('assets/images/person.png'),
                        ),
                      ],
                    );
                  } else {
                    print(snapshot.error.toString());
                    return Container();
                  }
                },
              ),
              const SizedBox(height: 40),
              Text(
                'Devices',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: ApiData.loadAppliances(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final appliances = snapshot.data!.appliances;
                      return GridView.builder(
                        itemCount: appliances.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context, index) {
                          final appliance = appliances[index];
                          bool valuee = appliance.value;
                          return AppliancesCard(
                            icon: appliance.icon,
                            name: appliance.type,
                            isOn: appliance.status,
                            value: valuee,
                            onToggle: (value) {
                              setState(() {
                                valuee = value;
                              });
                            },
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => ApplianceDetailsScreen(
                                    name: appliance.type,
                                    icon: appliance.icon,
                                    value: valuee,
                                    params: appliance.params,
                                    paramsValue: appliance.paramsValue,
                                    initial: appliance.initial,
                                    min: appliance.min,
                                    max: appliance.max,
                                    onToggle: (value) {
                                      setState(() {
                                        valuee = value;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      print(snapshot.error.toString());
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

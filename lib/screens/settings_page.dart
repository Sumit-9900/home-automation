import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_automation/provider/auth_provider.dart' as authprovider;
import 'package:home_automation/provider/theme_provider.dart';
import 'package:home_automation/screens/auth_page.dart';
import 'package:home_automation/services/utils/messages.dart';
import 'package:home_automation/widgets/profile_card.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController nameController = TextEditingController();
  String? name;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<authprovider.AuthProvider>(context);
    return StreamBuilder(
      stream:
          firestore.collection('user').doc(auth.currentUser!.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.hasData) {
          final data = snapshot.data!.data();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile Info',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    authProvider.selectedImage == null || name == null
                        ? errorMssg(
                            context, 'Please enter your name and image!!!')
                        : await authProvider.uploadData(name!);
                    if ((authProvider.selectedImage != null && name != null) &&
                        context.mounted) {
                      successMssg(context, 'Data successfully added!!!');
                    }
                  },
                  child: authProvider.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : const Text('Save'),
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: data != null
                                ? CachedNetworkImageProvider(data['imageUrl'])
                                : authProvider.selectedImage != null
                                    ? FileImage(authProvider.selectedImage!)
                                    : const AssetImage(
                                        'assets/images/person.png'),
                          ),
                          const SizedBox(width: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upload your Picture',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  final image =
                                      await authProvider.takePicture();
                                  if (image != null && context.mounted) {
                                    successMssg(context, 'Image selected!!!');
                                  } else if (image == null && context.mounted) {
                                    errorMssg(context, 'Image not selected!!!');
                                  }
                                },
                                label: const Text('Upload'),
                                icon: const Icon(Icons.upload),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ProfileCard(
                      icon: const Icon(Icons.person),
                      name: 'Name',
                      des: data != null ? data['name'] : name,
                      iconButton: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Name'),
                              content: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter your name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      name = nameController.text.trim();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Add'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Consumer<ThemeProvider>(
                      builder: (context, themeprovider, child) {
                        bool isDarkMode =
                            themeprovider.themeMode == ThemeMode.dark;
                        return ProfileCard(
                          icon: const Icon(Icons.light_mode),
                          name: 'Change your app theme',
                          onTap: () {
                            themeprovider.toggleTheme(!isDarkMode);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    ProfileCard(
                      icon: const Icon(Icons.logout),
                      name: 'LogOut',
                      onTap: () async {
                        await authProvider.logOut();
                        if (context.mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => const AuthPage(),
                            ),
                          );
                          successMssg(context, 'Log out successfully!!!');
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    ProfileCard(
                      icon: const Icon(Icons.delete),
                      name: 'Delete',
                      onTap: () async {
                        await authProvider.delete(name);
                        if (auth.currentUser == null && context.mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => const AuthPage(),
                            ),
                          );
                          successMssg(
                              context, 'Account deleted successfully!!!');
                        }
                        if (authProvider.mssg != null && context.mounted) {
                          errorMssg(context, 'Failed to delete account');
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        } else {
          print(snapshot.error.toString());
          return Container();
        }
      },
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _mssg;
  String? get mssg => _mssg;

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    _mssg = null;
    notifyListeners();

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      _mssg = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logIn(String email, String password) async {
    _isLoading = true;
    _mssg = null;
    notifyListeners();

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      _mssg = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void isLoginn() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  Future<void> logOut() async {
    await auth.signOut();
  }

  Future<void> delete(String? name) async {
    try {
      if (auth.currentUser != null) {
        if (_selectedImage != null && name!.isNotEmpty) {
          await deleteData();
          await auth.currentUser!.delete();
        } else {
          await auth.currentUser!.delete();
        }
      } else {
        return;
      }
    } catch (e) {
      _mssg = e.toString();
    }
  }

  Future<File?> takePicture() async {
    final ImagePicker imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File convertedImage = File(image.path);
      _selectedImage = convertedImage;
      notifyListeners();
      return _selectedImage;
    } else {
      _selectedImage = null;
      notifyListeners();
      return _selectedImage;
    }
  }

  Future<void> uploadData(String? name) async {
    _isLoading = true;
    notifyListeners();

    final TaskSnapshot taskSnapshot = await storage
        .ref()
        .child('profile-pic')
        .child(auth.currentUser!.uid)
        .putFile(_selectedImage!);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    Map<String, dynamic> data = {
      'name': name,
      'imageUrl': downloadUrl,
    };

    await firestore.collection('user').doc(auth.currentUser!.uid).set(data);

    name = null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteData() async {
    await storage
        .ref()
        .child('profile-pic')
        .child(auth.currentUser!.uid)
        .delete();

    await firestore.collection('user').doc(auth.currentUser!.uid).delete();
  }
}

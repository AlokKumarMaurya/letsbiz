import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GpsController extends GetxController{

  RxBool isLocationEnabled =false.obs;
  @override
  void onInit() {
    getGpsStatus().listen((event) {});
   Geolocator.isLocationServiceEnabled().then((value) => isLocationEnabled.value=value);
    // TODO: implement onInit
    super.onInit();
  }



  Stream<bool> getGpsStatus() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      isLocationEnabled.value=await Geolocator.isLocationServiceEnabled();
      print(isLocationEnabled);
      yield isLocationEnabled.value;
    }
  }










}
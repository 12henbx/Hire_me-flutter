import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:permission/permission.dart';
//import 'package:simple_permissions/simple_permissions.dart';

class Utils {
  static Future<bool> checkWritePermission() async {
bool okDone = false;
    if(Platform.isIOS){
      return false;
    }
    bool permission = false;
    /*await SimplePermissions
        .checkPermission(Permission.WriteExternalStorage)
        .then((bool checkOkay) {
      if (checkOkay == false) {
        SimplePermissions
            .requestPermission(Permission.WriteExternalStorage)
            .then((bool okDone) {
          if (okDone) {
            permission = true;
          }
        });
      } else {
        permission = true;
      }
    });*/
    return permission=true;
  }
}
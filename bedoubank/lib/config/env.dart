import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Env {
  Env._({@required this.apiBaseUrl});

  final String apiBaseUrl;

  factory Env.dev() {
    return new Env._(apiBaseUrl: "http://192.168.8.104:8000/");
  }
}

class Global {
  static final Global _instance = Global._private();

  Global._private();

  factory Global() => _instance;

  Env env = Env.dev();
}
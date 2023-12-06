import 'package:flutter/material.dart';

const String dataUrl = "https://www.prevision-meteo.ch/services/json";
const String searchUrl = "https://geo.api.gouv.fr/communes?nom=";
const String defaultBackgroundImage = "assets/weather/base.gif";

const int maxTemp = 50;
const int minTemp = -20;
const int diffTemp = maxTemp - minTemp;

const int defalutTimeoutTimer = 1000;

const double basePadding = 15;
const double defaultAppWidth = 800;
const double defaultAppHeight = 100;

const Color defaultAppBackgroundColor = Color.fromARGB(97, 0, 0, 0);

const String defaultCity = "Paris";

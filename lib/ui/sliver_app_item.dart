import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';
import 'package:meteo_app_v2/classes/master_app.dart';
import 'package:meteo_app_v2/classes/master_app_sliver.dart';
import 'package:meteo_app_v2/layouts/app_air.dart';
import 'package:meteo_app_v2/layouts/app_forcast_day.dart';
import 'package:meteo_app_v2/layouts/app_forcast_hour.dart';
import 'package:meteo_app_v2/layouts/app_heading.dart';
import 'package:meteo_app_v2/layouts/app_rain.dart';
import 'package:meteo_app_v2/layouts/app_wind.dart';
import 'package:meteo_app_v2/ui/sliver_body.dart';
import 'package:meteo_app_v2/ui/sliver_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverAppItem extends MasterAppSliver {
  final FontHelper? fontHelper;

  const SliverAppItem({
    super.key,
    required super.masterApp,
    this.fontHelper,
  });

  String masterAppLabel(final MasterApp masterApp) {
    switch (masterApp.runtimeType) {
      case AppHeading:
        return AppHeading.label;
      case AppForcastHour:
        return AppForcastHour.label;
      case AppForcastDay:
        return AppForcastDay.label;
      case AppWind:
        return AppWind.label;
      case AppAir:
        return AppAir.label;
      case AppRain:
        return AppRain.label;
      default:
        return "Unknown";
    }
  }

  IconData masterAppIcon(final MasterApp masterApp) {
    switch (masterApp.runtimeType) {
      case AppHeading:
        return AppHeading.icon;
      case AppForcastHour:
        return AppForcastHour.icon;
      case AppForcastDay:
        return AppForcastDay.icon;
      case AppWind:
        return AppWind.icon;
      case AppAir:
        return AppAir.icon;
      case AppRain:
        return AppRain.icon;
      default:
        return Icons.device_unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: <Widget>[
        // header
        SliverHeader(
          title: masterAppLabel(masterApp),
          icon: masterAppIcon(masterApp),
          fontHelper: fontHelper,
        ),

        // content
        SliverBody(
          masterApp: masterApp,
        ),
      ],
    );
  }
}

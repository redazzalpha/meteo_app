import 'package:flutter/material.dart';
import 'package:meteo_app_v2/classes/font_helper.dart';

class SliverMeteoCard extends StatelessWidget {
  final String cityName;
  final String conditions;
  final int currentTemperature;
  final int minTemperature;
  final int maxTemperature;
  final String backgroundImage;
  final FontHelper? fontHelper;

  const SliverMeteoCard({
    super.key,
    required this.cityName,
    required this.conditions,
    required this.currentTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.backgroundImage,
    this.fontHelper,
  });

  @override
  Widget build(BuildContext context) {
    FontHelper fh = fontHelper ?? FontHelper(context: context);

    return SliverPadding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 15,
        right: 15,
      ),
      sliver: SliverToBoxAdapter(
        child: GestureDetector(
          onTap: () => Navigator.pop(context, "Marseille"),
          child: Container(
            width: 320,
            height: 150,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(backgroundImage),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),

            // content
            child: Column(
              children: [
                // top content
                Row(
                  children: [
                    // city name
                    Text(
                      cityName,
                      style: fh.title(),
                    ),

                    const Spacer(),

                    // current temperature
                    Text(
                      "$currentTemperature°",
                      style: fh.display(),
                    ),
                  ],
                ),

                const Spacer(),

                // bottom content
                Row(
                  children: [
                    // conditions
                    Text(
                      conditions,
                      style: fh.label(),
                    ),

                    const Spacer(),

                    // min max temperature
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // icon arrow up
                        const Icon(
                          Icons.arrow_upward,
                        ),

                        // max temperature
                        Text(
                          "$maxTemperature°",
                          style: fh.label(),
                        ),

                        // padding boxed
                        const SizedBox(
                          width: 5,
                        ),

                        // icon arrow down
                        const Icon(
                          Icons.arrow_downward,
                        ),

                        // min temperature
                        Text(
                          "$minTemperature°",
                          style: fh.label(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

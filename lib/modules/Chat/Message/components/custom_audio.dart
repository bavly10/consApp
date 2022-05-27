import 'package:flutter/material.dart';

import '../../../../shared/my_colors.dart';

class CustomAudio extends StatelessWidget {
  Function()? labelTime;
  Function(BuildContext context, bool playing, String url) playing;
  bool isPlaying, isme;
  int? currentPos;
  String? currentLabel;
  var formattedData;
  int? duration;
  void Function(double)? onChanged;

  CustomAudio(
      {Key? key,
      this.labelTime,
      required this.playing,
      this.currentLabel,
      this.currentPos,
      this.formattedData,
      required this.isPlaying,
      required this.isme,
      this.onChanged,
      this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      //spacing: 0.0,
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              playing;
            },
            icon: isPlaying
                ? Icon(
                    Icons.pause_circle,
                    color: isme ? Colors.blueGrey : myAmber,
                  )
                : Icon(
                    Icons.play_arrow_rounded,
                    color: isme ? Colors.blueGrey : myAmber,
                  )),
        SizedBox(
          /// height: 20,
          width: MediaQuery.of(context).size.width * .25,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: isme ? Colors.white : Colors.blueGrey,
              inactiveTrackColor: isme ? Colors.blueGrey : Colors.white,
              trackHeight: 3.0,
              thumbColor: Colors.yellow,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
              overlayColor: Colors.purple.withAlpha(32),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
            ),
            child: Slider(
                autofocus: true,
                thumbColor: isme ? Colors.blueGrey : myAmber,
                value: double.parse(currentPos.toString()),
                min: 0.0,
                max: double.parse(duration.toString()),
                // divisions: ConsChat.get(context).duration,
                label: currentLabel,
                onChanged: onChanged),
          ),
        ),
        Text(
          currentLabel!,
          style: TextStyle(color: isme ? Colors.white : Colors.blueGrey),
        ),
        const SizedBox(
          width: 5,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 5,
            maxHeight: 14,
          ),
          child: Text(
            formattedData,
            style: TextStyle(
                fontSize: 11, color: isme ? Colors.white : Colors.black),
          ),
        ),
      ],
    );
  }
}

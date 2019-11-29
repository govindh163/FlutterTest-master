import 'package:flutter/material.dart';
import 'dart:async';
import 'package:volume/volume.dart';

class NativeVolume extends StatefulWidget {
  @override
  _NativeVolumeState createState() => _NativeVolumeState();
}

class _NativeVolumeState extends State<NativeVolume> {
  AudioManager audioManager;
  int maxVol, currentVol;


  @override
  void initState() {
    super.initState();
    audioManager = AudioManager.STREAM_SYSTEM;
    initPlatformState();
    updateVolumes();
  }

  Future<void> initPlatformState() async {
    await Volume.controlVolume(AudioManager.STREAM_SYSTEM);
  }

  updateVolumes() async {
    maxVol = await Volume.getMaxVol;
    currentVol = await Volume.getVol;
    setState(() {});
  }

  setVol(int i) async {
    await Volume.setVol(i);
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text('Native Volume Control'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              DropdownButton(
                value: audioManager,
                items: [
                  DropdownMenuItem(
                    child: Text("In Call Sound"),
                    value: AudioManager.STREAM_VOICE_CALL,
                  ),
                  DropdownMenuItem(
                    child: Text("System Volume"),
                    value: AudioManager.STREAM_SYSTEM,
                  ),
                  DropdownMenuItem(
                    child: Text("Ring Volume"),
                    value: AudioManager.STREAM_RING,
                  ),
                  DropdownMenuItem(
                    child: Text("Media Sound"),
                    value: AudioManager.STREAM_MUSIC,
                  ),
                  DropdownMenuItem(
                    child: Text("Alarm Sound"),
                    value: AudioManager.STREAM_ALARM,
                  ),
                  DropdownMenuItem(
                    child: Text("Notifications Volume"),
                    value: AudioManager.STREAM_NOTIFICATION,
                  ),
                ],
                isDense: true,
                onChanged: (AudioManager aM) async {
                  print(aM.toString());
                  setState(() {
                    audioManager = aM;
                  });
                  await Volume.controlVolume(aM);
                },
              ),
              (currentVol != null || maxVol != null)
                  ? Slider(
                activeColor: Colors.redAccent,
                value: currentVol / 1.0,
                divisions: maxVol,
                max: maxVol / 1.0,
                min: 0,
                onChanged: (double d) {
                  setVol(d.toInt());
                  updateVolumes();
                },
              )
                  : Container(),
            ],
          ),
        ),
      );
  }
}
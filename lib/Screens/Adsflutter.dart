import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'DE8865B2B05D7139DD4BB0EBB86F51FE';

class AdmobFlutter extends StatefulWidget {
  @override
  _AdmobFlutterState createState() => _AdmobFlutterState();
}

class _AdmobFlutterState extends State<AdmobFlutter> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Flutter Ad"),
        ),
        body: Center(
            child: RaisedButton(
              child: Text('Click on Ads'),
              onPressed: () {
                createInterstitialAd()
                  ..load()
                  ..show();
              },
            ),) ,);

  }
}
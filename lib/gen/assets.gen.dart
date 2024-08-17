/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $LibGen {
  const $LibGen();

  /// Directory path: lib/shared
  $LibSharedGen get shared => const $LibSharedGen();
}

class $AssetsI18nGen {
  const $AssetsI18nGen();

  /// File path: assets/i18n/ar.json
  String get ar => 'assets/i18n/ar.json';

  /// File path: assets/i18n/en.json
  String get en => 'assets/i18n/en.json';

  /// File path: assets/i18n/ku.json
  String get ku => 'assets/i18n/ku.json';

  /// File path: assets/i18n/tr.json
  String get tr => 'assets/i18n/tr.json';

  /// List of all assets
  List<String> get values => [ar, en, ku, tr];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Flag_of_Iraq.svg.png
  AssetGenImage get flagOfIraqSvg =>
      const AssetGenImage('assets/images/Flag_of_Iraq.svg.png');

  /// File path: assets/images/Flag_of_Kurdistan.svg.png
  AssetGenImage get flagOfKurdistanSvg =>
      const AssetGenImage('assets/images/Flag_of_Kurdistan.svg.png');

  /// File path: assets/images/Flag_of_Turkey.svg.png
  AssetGenImage get flagOfTurkeySvg =>
      const AssetGenImage('assets/images/Flag_of_Turkey.svg.png');

  /// File path: assets/images/Untitledddxfcg.jpg
  AssetGenImage get untitledddxfcg =>
      const AssetGenImage('assets/images/Untitledddxfcg.jpg');

  /// File path: assets/images/Untitledzzzzxxcc.jpg
  AssetGenImage get untitledzzzzxxcc =>
      const AssetGenImage('assets/images/Untitledzzzzxxcc.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        flagOfIraqSvg,
        flagOfKurdistanSvg,
        flagOfTurkeySvg,
        untitledddxfcg,
        untitledzzzzxxcc
      ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/bookmark.json
  String get bookmark => 'assets/lottie/bookmark.json';

  /// File path: assets/lottie/driver.json
  String get driver => 'assets/lottie/driver.json';

  /// List of all assets
  List<String> get values => [bookmark, driver];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/Secure login-rafiki.svg
  String get secureLoginRafiki => 'assets/svg/Secure login-rafiki.svg';

  /// List of all assets
  List<String> get values => [secureLoginRafiki];
}

class $LibSharedGen {
  const $LibSharedGen();

  /// File path: lib/shared/.env
  String get aEnv => 'lib/shared/.env';

  /// List of all assets
  List<String> get values => [aEnv];
}

class Assets {
  Assets._();

  static const $AssetsI18nGen i18n = $AssetsI18nGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
  static const $LibGen lib = $LibGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

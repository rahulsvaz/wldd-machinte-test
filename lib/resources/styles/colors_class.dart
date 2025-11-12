import 'package:flutter/material.dart';

class Palette {




  static const Color kPrimary = Color(0xff083C5D);
  static const Color kSecondary = Color(0xff343a40);
  static const Color scaffoldBackground = Color(0xFF0F0F0F);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00FFFFFF);

  static const Color textPrimary = Color(0xFF020218);
  static const Color textSecondary = Color(0xFF707070);
  static const Color textDark = Color(0xFF4B4B4B);
  static const Color textLight = Color(0xFF333333);
  static const Color textMuted = Color(0xFF82859B);
  static const Color textGrey = Color(0xFF777A7A);
  static const Color textLabel = Color(0xFF646464);

  static const Color green = Color(0xFF34B06D);
  static const Color greenDark = Color(0xFF089A34);
  static const Color greenLight = Color(0xFF0EBE0E);
  static const Color greenPastel = Color(0xFFABFEB7);
  static const Color greenMint = Color(0xFFCEEEE5);
  static const Color greenTint = Color(0xFFE6F6F2);
  static const Color greenBackground = Color(0xFFDAF8DE);

  static const Color blue = Color(0xFF2275F0);
  static const Color blueDark = Color(0xFF0F5497);
  static const Color blueSteel = Color(0xFF357CC2);
  static const Color blueLight = Color(0xFF5DABF5);
  static const Color blueSky = Color(0xFF2CC2DA);
  static const Color blueVivid = Color(0xFF3399FF);
  static const Color blueBaby = Color(0xFFE5EDF9);
  static const Color bluePastel = Color(0xFFE9F0FA);
  static const Color blueTint = Color(0xFFE2F0FF);
  static const Color blueBackground = Color(0xFFDAF0F9);
  static const Color blueGrey = Color(0xFFE0EAF5);

  static const Color purple = Color(0xFF821A82);
  static const Color purpleLight = Color(0xFF9E7EF3);
  static const Color purpleViolet = Color(0xFF7D79C2);
  static const Color purpleLavender = Color(0xFFB2ABFE);
  static const Color purpleTint = Color(0xFFE8EDFD);

  static const Color red = Color(0xFFD91D1D);
  static const Color redDark = Color(0xFFB4252B);
  static const Color redBright = Color(0xFFF6464B);
  static const Color redLight = Color(0xFFF3717A);
  static const Color redPink = Color(0xFFFF4779);
  static const Color redDot = Color(0xFFF35B5B);
  static const Color redTint = Color(0xFFFBE6E6);

  static const Color orange = Color(0xFFFF8041);
  static const Color orangeLight = Color(0xFFFB923B);
  static const Color orangeRose = Color(0xFFD62893);

  static const Color yellow = Color(0xFFFFC041);
  static const Color yellowDark = Color(0xFFFFC444);
  static const Color yellowGold = Color(0xFF906B0C);
  static const Color yellowAmber = Color(0xFFFEE6AB);
  static const Color yellowBorder = Color(0xFFFFBC1E);
  static const Color yellowTint = Color(0xFFFFFCEC);

  static const Color pink = Color(0xFFFFCEED);
  static const Color pinkLight = Color(0xFFFE5EDF9);

  static Color grey = Colors.grey[600]!;
  static const Color greyLight = Color(0xFFD2D7D2);
  static const Color greyMedium = Color(0xFFA0A5B9);
  static const Color greyDark = Color(0xFF666467);
  static const Color greyUltraDark = Color(0xFFA9A9A9);
  static const Color greyBlue = Color(0xFF868AAA);
  static const Color greyBorder = Color(0xFFE7EAF4);
  static const Color greyFill = Color(0xFFF5F4F8);
  static const Color greyBackground = Color(0xFFF8F9FB);
  static const Color greyShimmer = Color(0xFF989A9A);

  static const Color surface = Color(0xFFF8F8F8);
  static const Color surfaceLight = Color(0xFFF7F7F7);
  static const Color surfaceTint = Color(0xFFFAFAFA);
  static const Color surfaceGrey = Color(0xFFF4F4F4);
  static const Color surfaceOffWhite = Color(0xFFF0F0F0);
  static const Color surfaceWhite = Color(0xFFFCFCFC);
  static const Color surfaceShaded = Color(0xFFF3F6FC);
  static const Color surfaceSteelGray = Color(0xFFF6F6F6);

  static const Color borderGrey = Color(0xFFE2E2E2);
  static const Color borderLight = Color(0xFFE0DEDE);
  static const Color borderLightGrey = Color(0xFFF2F3F6);
  static const Color borderBlue = Color(0xFFB6E6F3);
  static const Color borderSteelBlue = Color(0xFFB3B6CC);
  static const Color borderGreen = Color(0xFFE7F1F2);
  static const Color border = Color(0xFFE6E6E6);

  static const Color statusPaid = Color(0xFF34B06D);
  static const Color statusPaidBackground = Color(0xFFFAFFFD);
  static const Color statusPaidIcon = Color(0xFFBBF6D7);

  static const Color statusPartiallyPaid = Color(0xFFFFBC1E);
  static const Color statusPartiallyPaidBackground = Color(0xFFFDFBF7);
  static const Color statusPartiallyPaidIcon = Color(0xFFF9EBCA);

  static const Color statusUnpaid = Color(0xFFF6454B);
  static const Color statusUnpaidBackground = Color(0xFFFFFCFC);
  static const Color statusUnpaidIcon = Color(0xFFF9CACA);

  static const Color statusAvailable = Color(0xFFD9D9D9);
  static const Color statusBooked = Color(0xFFF0BE4C);
  static const Color statusOccupied = Color(0xFFD62893);
  static const Color statusBilled = Color(0xFF707070);

  static const Color statusAuthorized = Color(0xFF34B06D);
  static const Color statusAuthorizedBackground = Color(0xFFDEFEEA);

  static const Gradient gradientYellow = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFE198), Color(0xFFFFFFC9)],
  );

  static const Gradient gradientPink = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFDFB7E9), Color(0xFFFFF9E8)],
  );

  static const Gradient gradientMint = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.center,
    colors: [Color(0xFFDBF2EA), Color(0xFFFFFFFF)],
  );

  static const Gradient gradientAppbar = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFCEEEE5), Color(0xFFF7FAF5)],
  );

  static const Gradient gradientDark = LinearGradient(
    colors: [Color(0xFF022219), Color(0xFF088864)],
  );
}

class AppShadows {
  static List<BoxShadow> get defaultShadow => [
    BoxShadow(
      color: const Color(0xFFF0F0F0).withOpacity(0.8),
      spreadRadius: 8,
      blurRadius: 8,
      offset: const Offset(0, 0),
    ),
  ];

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 0),
      blurRadius: 8,
    ),
  ];
}
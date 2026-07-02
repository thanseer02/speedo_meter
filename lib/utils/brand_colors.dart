import 'package:flutter/material.dart';
import 'package:speedtrack/utils/colors.dart';

/// Brand colors theme extension for light/dark theming across the app.
class AppBrandColors extends ThemeExtension<AppBrandColors> {
  final Color textColor;
  final Color textColor2;
  final Color textColor3;
  final Color textFieldColor;
  final Color hintTextColor;
  final Color borderColor;
  final Color appBarColor;
  final Color containerColor;
  final Color secondaryTextColor;
  final Color bottomNavbarColor;
  final Color secondaryBgColor;
  final Color bgColor;
  final Color dividerColor;
  final Color svgBgColor;
  final Color counterBoarderColor;
  final Color counterTextColor;
  final Color subTitleTextColor;
  final Color counterOperatorColor;
  final Color svgBgColor2;
  final Color borderColor2;
  final Color switchCircleColor;
  final Color borderColor3;
  final Color containerColor2;
  final Color containerColor4;
  final Color counterBgColor;
  final Color counterDividerColor;
  final Color svgBgColor3;
  final Color borderColor4;
  final Color containerColor3;
  final Color borderColor5;
  final Color svgBgColor4;
  final Color borderColor6;
  final Color smallIconBgColor;
  final Color textColor4;
  final Color tableOddRowColor;
  final Color tableEvenRowColor;
  final Color tableBorderColor;
  final Color tableGridColor;
  final Color progressBarColor;
  final Color lightRedBg;
  final Color actionRed;
  final Color primaryRed;
  final Color filterChipColor;
  final Color passGreen;
  final Color failedRed;
  final Color textColor5;

  const AppBrandColors({
    required this.textColor,
    required this.textColor2,
    required this.textColor3,
    required this.textColor4,
    required this.textFieldColor,
    required this.hintTextColor,
    required this.borderColor,
    required this.appBarColor,
    required this.containerColor,
    required this.secondaryTextColor,
    required this.bottomNavbarColor,
    required this.secondaryBgColor,
    required this.bgColor,
    required this.dividerColor,
    required this.svgBgColor,
    required this.counterBoarderColor,
    required this.counterTextColor,
    required this.subTitleTextColor,
    required this.counterOperatorColor,
    required this.svgBgColor2,
    required this.borderColor2,
    required this.switchCircleColor,
    required this.borderColor3,
    required this.containerColor2,
    required this.counterBgColor,
    required this.counterDividerColor,
    required this.svgBgColor3,
    required this.borderColor4,
    required this.containerColor3,
    required this.containerColor4,
    required this.borderColor5,
    required this.svgBgColor4,
    required this.borderColor6,
    required this.smallIconBgColor,
    required this.tableOddRowColor,
    required this.tableEvenRowColor,
    required this.tableBorderColor,
    required this.tableGridColor,
    required this.progressBarColor,
    required this.lightRedBg,
    required this.actionRed,
    required this.primaryRed,
    required this.filterChipColor,
    required this.passGreen,
    required this.failedRed,
    required this.textColor5,
  });

  factory AppBrandColors.fromScheme(ColorScheme s, {required bool isDark}) {
    return AppBrandColors(
      textColor: isDark ? Colors.white : Colors.black,
      textColor2: isDark ? AppColors.color7B808D : AppColors.color121212,
      textColor3: isDark ? AppColors.colorWhite : AppColors.color151414,
      textColor4: isDark ? AppColors.color8A8A8E : AppColors.colorBlack,
      textFieldColor: isDark ? Colors.transparent : AppColors.colorWhite,
      hintTextColor: isDark ? AppColors.color7B808D : AppColors.color626262,
      borderColor: isDark ? AppColors.color4D4D4D : AppColors.colorD1D1D1,
      borderColor2: isDark ? AppColors.color282828 : AppColors.colorFAD3D3,
      borderColor3: isDark ? AppColors.color4D4D4D : AppColors.colorF6B6B4,
      borderColor4: isDark ? AppColors.color282828 : AppColors.colorDCDCDC,
      borderColor5: isDark ? AppColors.color282828 : AppColors.colorEBEBEB,
      borderColor6: isDark ? AppColors.color282828 : AppColors.colorF6E8E8,
      appBarColor: isDark ? AppColors.colorBlack : AppColors.colorWhite,
      containerColor: isDark ? AppColors.color515151 : AppColors.colorWhite,
      containerColor2: isDark ? AppColors.color1E1E1E : AppColors.colorFEF6F6,
      containerColor3: isDark ? AppColors.color212121 : Colors.transparent,
      containerColor4: isDark ? AppColors.color1E1E1E : AppColors.colorFEFEFE,
      secondaryTextColor: isDark ? Colors.white : AppColors.color626262,
      textColor5: isDark ? Colors.white : AppColors.color767676,
      bottomNavbarColor: isDark ? Colors.transparent : AppColors.colorWhite,
      secondaryBgColor: isDark ? AppColors.color1E1E1E : AppColors.colorWhite,
      bgColor: isDark ? AppColors.color151515 : AppColors.colorWhite,
      dividerColor: isDark ? AppColors.color515151 : AppColors.colorFDE9EA,
      svgBgColor: isDark ? AppColors.color383838 : AppColors.colorF7F7F7,
      counterBoarderColor:
          isDark ? AppColors.color999999 : AppColors.colorC4BABB,
      counterTextColor: isDark ? AppColors.color999999 : AppColors.color121212,
      subTitleTextColor: isDark ? AppColors.color999999 : AppColors.color626262,
      counterOperatorColor:
          isDark ? AppColors.color999999 : AppColors.color1C1D1D,
      svgBgColor2: isDark ? AppColors.color454545 : AppColors.colorWhite,
      svgBgColor3: isDark ? AppColors.color620103 : AppColors.colorWhite,
      svgBgColor4: isDark ? AppColors.color482417 : AppColors.colorFFE9E0,
      switchCircleColor: isDark ? AppColors.color331515 : AppColors.colorWhite,
      counterBgColor: isDark ? Colors.transparent : AppColors.colorFCFFFF,
      counterDividerColor:
          isDark ? AppColors.color464646 : AppColors.colorC4BABB,
      smallIconBgColor: isDark ? AppColors.color282828 : AppColors.colorFFE9E0,
      tableOddRowColor: isDark ? AppColors.color2A1A1C : AppColors.colorFDECED,
      tableEvenRowColor: isDark ? AppColors.color1C1C1E : AppColors.colorWhite,
      tableGridColor: isDark ? AppColors.color2E2E2E : AppColors.colorWhite,
      progressBarColor: isDark ? AppColors.color92A592 : AppColors.colorE5E7EB,
      tableBorderColor: isDark ? AppColors.color3A3A3C : AppColors.colorEBEBEB,
      lightRedBg: isDark ? AppColors.color521717 : AppColors.colorFFF1EE,
      actionRed: isDark ? AppColors.colorFF4B3A : AppColors.colorFF4B3A,
      filterChipColor: isDark ? AppColors.colorFF4B3A : AppColors.colorBlack,
      primaryRed: isDark ? AppColors.colorE02B20 : AppColors.colorE02B20,
      passGreen: isDark ? AppColors.color2FDC49 : AppColors.color399647,
      failedRed: isDark ? AppColors.colorF83742 : AppColors.colorBD0F1A,
    );
  }

  @override
  AppBrandColors copyWith({
    Color? textColor,
    Color? textFieldColor,
    Color? hintTextColor,
    Color? borderColor,
    Color? appBarColor,
    Color? containerColor,
    Color? secondaryTextColor,
    Color? bottomNavbarColor,
    Color? secondaryBgColor,
    Color? bgColor,
    Color? dividerColor,
    Color? svgBgColor,
    Color? counterBoarderColor,
    Color? counterTextColor,
    Color? subTitleTextColor,
    Color? counterOperatorColor,
    Color? svgBgColor2,
    Color? borderColor2,
    Color? switchCircleColor,
    Color? borderColor3,
    Color? containerColor2,
    Color? counterBgColor,
    Color? counterDividerColor,
    Color? svgBgColor3,
    Color? textColor2,
    Color? borderColor4,
    Color? containerColor3,
    Color? containerColor4,
    Color? borderColor5,
    Color? svgBgColor4,
    Color? borderColor6,
    Color? textColor3,
    Color? textColor4,
    Color? smallIconBgColor,
    Color? tableOddRowColor,
    Color? tableEvenRowColor,
    Color? tableBorderColor,
    Color? tableGridColor,
    Color? progressBarColor,
    Color? lightRedBg,
    Color? actionRed,
    Color? primaryRed,
    Color? filterChipColor,
    Color? passGreen,
    Color? failedRed,
    Color? textColor5,
  }) {
    return AppBrandColors(
      textColor: textColor ?? this.textColor,
      textColor3: textColor ?? this.textColor3,
      textFieldColor: textFieldColor ?? this.textFieldColor,
      hintTextColor: hintTextColor ?? this.hintTextColor,
      borderColor: borderColor ?? this.borderColor,
      appBarColor: appBarColor ?? this.appBarColor,
      containerColor: containerColor ?? this.containerColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      bottomNavbarColor: bottomNavbarColor ?? this.bottomNavbarColor,
      secondaryBgColor: secondaryBgColor ?? this.secondaryBgColor,
      bgColor: bgColor ?? this.bgColor,
      dividerColor: dividerColor ?? this.dividerColor,
      svgBgColor: svgBgColor ?? this.svgBgColor,
      counterBoarderColor: counterBoarderColor ?? this.counterBoarderColor,
      counterTextColor: counterTextColor ?? this.counterTextColor,
      subTitleTextColor: subTitleTextColor ?? this.subTitleTextColor,
      counterOperatorColor: counterOperatorColor ?? this.counterOperatorColor,
      svgBgColor2: svgBgColor2 ?? this.svgBgColor2,
      borderColor2: borderColor2 ?? this.borderColor2,
      switchCircleColor: switchCircleColor ?? this.switchCircleColor,
      borderColor3: borderColor3 ?? this.borderColor3,
      containerColor2: containerColor2 ?? this.containerColor2,
      containerColor4: containerColor4 ?? this.containerColor4,
      counterBgColor: counterBgColor ?? this.counterBgColor,
      counterDividerColor: counterDividerColor ?? this.counterDividerColor,
      svgBgColor3: svgBgColor3 ?? this.svgBgColor3,
      textColor2: textColor2 ?? this.textColor2,
      borderColor4: borderColor4 ?? this.borderColor4,
      containerColor3: containerColor3 ?? this.containerColor3,
      borderColor5: borderColor5 ?? this.borderColor5,
      svgBgColor4: svgBgColor4 ?? this.svgBgColor4,
      borderColor6: borderColor6 ?? this.borderColor6,
      smallIconBgColor: smallIconBgColor ?? this.smallIconBgColor,
      textColor4: textColor4 ?? this.textColor4,
      tableOddRowColor: tableOddRowColor ?? this.tableOddRowColor,
      tableEvenRowColor: tableEvenRowColor ?? this.tableEvenRowColor,
      tableBorderColor: tableBorderColor ?? this.tableBorderColor,
      tableGridColor: tableGridColor ?? this.tableGridColor,
      progressBarColor: progressBarColor ?? this.progressBarColor,
      lightRedBg: lightRedBg ?? this.lightRedBg,
      actionRed: actionRed ?? this.actionRed,
      primaryRed: primaryRed ?? this.primaryRed,
      filterChipColor: filterChipColor ?? this.filterChipColor,
      passGreen: passGreen ?? this.passGreen,
      failedRed: failedRed ?? this.failedRed,
      textColor5: textColor5 ?? this.textColor5,
    );
  }

  @override
  AppBrandColors lerp(
    ThemeExtension<AppBrandColors>? other,
    double t,
  ) {
    if (other is! AppBrandColors) return this;

    return AppBrandColors(
        textColor: Color.lerp(textColor, other.textColor, t)!,
        textColor3: Color.lerp(textColor3, other.textColor3, t)!,
        textFieldColor: Color.lerp(textFieldColor, other.textFieldColor, t)!,
        hintTextColor: Color.lerp(hintTextColor, other.hintTextColor, t)!,
        appBarColor: Color.lerp(appBarColor, other.appBarColor, t)!,
        borderColor: Color.lerp(borderColor, other.borderColor, t)!,
        borderColor2: Color.lerp(borderColor2, other.borderColor2, t)!,
        containerColor: Color.lerp(containerColor, other.containerColor, t)!,
        borderColor4: Color.lerp(borderColor4, other.borderColor4, t)!,
        borderColor5: Color.lerp(borderColor5, other.borderColor5, t)!,
        counterDividerColor:
            Color.lerp(counterDividerColor, other.counterDividerColor, t)!,
        secondaryTextColor:
            Color.lerp(secondaryTextColor, other.secondaryTextColor, t)!,
        bottomNavbarColor:
            Color.lerp(bottomNavbarColor, other.bottomNavbarColor, t)!,
        secondaryBgColor:
            Color.lerp(secondaryBgColor, other.secondaryBgColor, t)!,
        bgColor: Color.lerp(bgColor, other.bgColor, t)!,
        dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
        svgBgColor: Color.lerp(svgBgColor, other.svgBgColor, t)!,
        svgBgColor2: Color.lerp(svgBgColor2, other.svgBgColor2, t)!,
        borderColor3: Color.lerp(borderColor3, other.borderColor3, t)!,
        containerColor2: Color.lerp(containerColor2, other.containerColor2, t)!,
        containerColor4: Color.lerp(containerColor4, other.containerColor4, t)!,
        counterBgColor: Color.lerp(counterBgColor, other.counterBgColor, t)!,
        svgBgColor3: Color.lerp(svgBgColor3, other.svgBgColor3, t)!,
        textColor2: Color.lerp(textColor2, other.textColor2, t)!,
        containerColor3: Color.lerp(containerColor3, other.containerColor3, t)!,
        borderColor6: Color.lerp(borderColor6, other.borderColor6, t)!,
        filterChipColor: Color.lerp(filterChipColor, other.filterChipColor, t)!,
        failedRed: Color.lerp(failedRed, other.failedRed, t)!,
        passGreen: Color.lerp(passGreen, other.passGreen, t)!,
        progressBarColor:
            Color.lerp(progressBarColor, other.progressBarColor, t)!,
        counterBoarderColor:
            Color.lerp(counterBoarderColor, other.counterBoarderColor, t)!,
        counterTextColor:
            Color.lerp(counterTextColor, other.counterTextColor, t)!,
        subTitleTextColor:
            Color.lerp(subTitleTextColor, other.subTitleTextColor, t)!,
        counterOperatorColor:
            Color.lerp(counterOperatorColor, other.counterOperatorColor, t)!,
        switchCircleColor:
            Color.lerp(switchCircleColor, other.switchCircleColor, t)!,
        svgBgColor4: Color.lerp(svgBgColor4, other.svgBgColor4, t)!,
        tableGridColor: Color.lerp(tableGridColor, other.tableGridColor, t)!,
        smallIconBgColor:
            Color.lerp(smallIconBgColor, other.smallIconBgColor, t)!,
        textColor4: Color.lerp(textColor4, other.textColor4, t)!,
        tableBorderColor:
            Color.lerp(tableBorderColor, other.tableBorderColor, t)!,
        tableOddRowColor:
            Color.lerp(tableOddRowColor, other.tableOddRowColor, t)!,
        lightRedBg: Color.lerp(lightRedBg, other.lightRedBg, t)!,
        actionRed: Color.lerp(actionRed, other.actionRed, t)!,
        textColor5: Color.lerp(textColor5, other.textColor5, t)!,
        primaryRed: Color.lerp(primaryRed, other.primaryRed, t)!,
        tableEvenRowColor:
            Color.lerp(tableEvenRowColor, other.tableEvenRowColor, t)!);
  }
}

extension AppBrandColorsContext on BuildContext {
  AppBrandColors get brand => Theme.of(this).extension<AppBrandColors>()!;
}

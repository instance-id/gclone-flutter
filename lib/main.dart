import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gclone/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

import 'app_home.dart';

// The client and host sides of a channel are connected through
// a channel name passed in the channel constructor.

void main() {
  runApp(
    MaterialApp(
      title: 'gclone',
      theme: ThemeData(
        primarySwatch: MaterialColor(4280361249, {
          50: Color(0xfff2f2f2),
          100: Color(0xffe6e6e6),
          200: Color(0xffcccccc),
          300: Color(0xffb3b3b3),
          400: Color(0xff999999),
          500: Color(0xff808080),
          600: Color(0xff666666),
          700: Color(0xff4d4d4d),
          800: Color(0xff333333),
          900: Color(0xff191919)
        }),
        brightness: Brightness.dark,
        primaryColor: Color(0xff212121),
        primaryColorBrightness: Brightness.dark,
        primaryColorLight: Color(0xff9e9e9e),
        primaryColorDark: Color(0xff000000),
        accentColor: Color(0xff64ffda),
        accentColorBrightness: Brightness.light,
        canvasColor: Color(0xff303030),
        scaffoldBackgroundColor: Color(0xff303030),
        bottomAppBarColor: Color(0xff424242),
        cardColor: Color(0xff424242),
        dividerColor: Color(0x1fffffff),
        highlightColor: Color(0x40cccccc),
        splashColor: Color(0x40cccccc),
        selectedRowColor: Color(0xfff5f5f5),
        unselectedWidgetColor: Color(0xb3ffffff),
        disabledColor: Color(0x4dffffff),
        buttonColor: Color(0xff666666),
        toggleableActiveColor: Color(0xff64ffda),
        secondaryHeaderColor: Color(0xff616161),
        textSelectionColor: Color(0xff64ffda),
        cursorColor: Color(0xff4285f4),
        textSelectionHandleColor: Color(0xff1de9b6),
        backgroundColor: Color(0xff616161),
        dialogBackgroundColor: Color(0xff424242),
        indicatorColor: Color(0xff64ffda),
        hintColor: Color(0x80ffffff),
        errorColor: Color(0xffd32f2f),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.normal,
          minWidth: 88.0,
          height: 36.0,
          padding:
              EdgeInsets.only(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xff000000),
              width: 0.0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          alignedDropdown: false,
          buttonColor: Color(0xff666666),
          disabledColor: Color(0x4dffffff),
          highlightColor: Color(0x29ffffff),
          splashColor: Color(0x1fffffff),
          colorScheme: ColorScheme(
            primary: Color(0xff2d2d2d),
            primaryVariant: Color(0xff000000),
            secondary: Color(0xff64ffda),
            secondaryVariant: Color(0xff00bfa5),
            surface: Color(0xff424242),
            background: Color(0xff616161),
            error: Color(0xffd32f2f),
            onPrimary: Color(0xffffffff),
            onSecondary: Color(0xff000000),
            onSurface: Color(0xffffffff),
            onBackground: Color(0xffffffff),
            onError: Color(0xff000000),
            brightness: Brightness.dark,
          ),
        ),
        textTheme: TextTheme(
          display4: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: 96.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
          display3: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: 60.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
          display2: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: 48.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          display1: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: 34.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headline: TextStyle(
            color: Color(0xffffffff),
            fontSize: 24.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          title: TextStyle(
            color: Color(0xffffffff),
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          subhead: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          body2: TextStyle(
            color: Color(0xffffffff),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          body1: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          caption: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          button: TextStyle(
            color: Color(0xffffffff),
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          subtitle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          overline: TextStyle(
            color: Color(0xffffffff),
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        primaryTextTheme: TextTheme(
          display4: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: 96.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
          display3: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: 60.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
          display2: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: 48.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          display1: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: 34.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headline: TextStyle(
            color: Color(0xffffffff),
            fontSize: 24.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          title: TextStyle(
            color: Color(0xffffffff),
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          subhead: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          body2: TextStyle(
            color: Color(0xffffffff),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          body1: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          caption: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          button: TextStyle(
            color: Color(0xffffffff),
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          subtitle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          overline: TextStyle(
            color: Color(0xffffffff),
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        accentTextTheme: TextTheme(
          display4: TextStyle(
            color: Color(0x8a000000),
            fontSize: 96.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
          display3: TextStyle(
            color: Color(0x8a000000),
            fontSize: 60.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
          display2: TextStyle(
            color: Color(0x8a000000),
            fontSize: 48.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          display1: TextStyle(
            color: Color(0x8a000000),
            fontSize: 34.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headline: TextStyle(
            color: Color(0xdd000000),
            fontSize: 24.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          title: TextStyle(
            color: Color(0xdd000000),
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          subhead: TextStyle(
            color: Color(0xdd000000),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          body2: TextStyle(
            color: Color(0xdd000000),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          body1: TextStyle(
            color: Color(0xdd000000),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          caption: TextStyle(
            color: Color(0x8a000000),
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          button: TextStyle(
            color: Color(0xdd000000),
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          subtitle: TextStyle(
            color: Color(0xff000000),
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          overline: TextStyle(
            color: Color(0xff000000),
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          helperStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          hintStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          errorStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          errorMaxLines: null,
          hasFloatingPlaceholder: true,
          isDense: false,
          contentPadding:
              EdgeInsets.only(top: 12.0, bottom: 12.0, left: 0.0, right: 0.0),
          isCollapsed: false,
          prefixStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          suffixStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          counterStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          filled: false,
          fillColor: Color(0x00000000),
//          errorBorder: UnderlineInputBorder(
//            side: BorderSide(color: Color(0xff000000), width: 1.0, style: BorderStyle.solid, ),
//            borderRadius: BorderRadius.all(Radius.circular(4.0)),
//          ),
//          focusedBorder: UnderlineInputBorder(
//            side: BorderSide(color: Color(0xff000000), width: 1.0, style: BorderStyle.solid, ),
//            borderRadius: BorderRadius.all(Radius.circular(4.0)),
//          ),
//          focusedErrorBorder: UnderlineInputBorder(
//            side: BorderSide(color: Color(0xff000000), width: 1.0, style: BorderStyle.solid, ),
//            borderRadius: BorderRadius.all(Radius.circular(4.0)),
//          ),
//          disabledBorder: UnderlineInputBorder(
//            side: BorderSide(color: Color(0xff000000), width: 1.0, style: BorderStyle.solid, ),
//            borderRadius: BorderRadius.all(Radius.circular(4.0)),
//          ),
//          enabledBorder: UnderlineInputBorder(
//            side: BorderSide(color: Color(0xff000000), width: 1.0, style: BorderStyle.solid, ),
//            borderRadius: BorderRadius.all(Radius.circular(4.0)),
//          ),
//          border: UnderlineInputBorder(
//            side: BorderSide(color: Color(0xff000000), width: 1.0, style: BorderStyle.solid, ),
//            borderRadius: BorderRadius.all(Radius.circular(4.0)),
//          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xffffffff),
          opacity: 1.0,
          size: 24.0,
        ),
        primaryIconTheme: IconThemeData(
          color: Color(0xffffffff),
          opacity: 1.0,
          size: 24.0,
        ),
        accentIconTheme: IconThemeData(
          color: Color(0xff000000),
          opacity: 1.0,
          size: 24.0,
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Color(0xff212121),
          inactiveTrackColor: Color(0x3d212121),
          disabledActiveTrackColor: Color(0x52000000),
          disabledInactiveTrackColor: Color(0x1f000000),
          activeTickMarkColor: Color(0x8a9e9e9e),
          inactiveTickMarkColor: Color(0x8a212121),
          disabledActiveTickMarkColor: Color(0x1f9e9e9e),
          disabledInactiveTickMarkColor: Color(0x1f000000),
          thumbColor: Color(0xff212121),
          disabledThumbColor: Color(0x52000000),
          thumbShape: RoundSliderThumbShape(),
          overlayColor: Color(0x29212121),
          valueIndicatorColor: Color(0xff212121),
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          showValueIndicator: ShowValueIndicator.onlyForDiscrete,
          valueIndicatorTextStyle: TextStyle(
            color: Color(0xdd000000),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Color(0xffffffff),
          unselectedLabelColor: Color(0xb2ffffff),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Color(0x1fffffff),
          brightness: Brightness.dark,
          deleteIconColor: Color(0xdeffffff),
          disabledColor: Color(0x0cffffff),
          labelPadding:
              EdgeInsets.only(top: 0.0, bottom: 0.0, left: 8.0, right: 8.0),
          labelStyle: TextStyle(
            color: Color(0xdeffffff),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          padding:
              EdgeInsets.only(top: 4.0, bottom: 4.0, left: 4.0, right: 4.0),
          secondaryLabelStyle: TextStyle(
            color: Color(0x3dffffff),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          secondarySelectedColor: Color(0x3d212121),
          selectedColor: Color(0x3dffffff),
          shape: StadiumBorder(
              side: BorderSide(
            color: Color(0xff000000),
            width: 0.0,
            style: BorderStyle.none,
          )),
        ),
        dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xff000000),
            width: 0.0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        )),
      ),
      // No need to set `home` because `routes` is set to a routing table, and
      // Navigator.defaultRouteName ('/') has an entry in it.
      home: ChangeNotifierProvider<NavigationProvider>(
        builder: (_) => NavigationProvider(),
        child: AppHome(),
      ),
    ),
  );
}

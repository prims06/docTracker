import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class ColorApp {
  static late Color shadowColor;
  static late Color primaryText;
  static late Color secondaryText;
  static late Color disabledText;
  static late Color fieldColor;
  static late Color blackWhiteColor;
  static late Color defaultBackgroundColor;
  static late Color separateColor;
  static late Color bagwhite;
  void init(BuildContext context) {
    primaryText = Theme.of(context).primaryColorLight;
    secondaryText = Theme.of(context).primaryColorDark;
    fieldColor = Theme.of(context).unselectedWidgetColor;
    disabledText = Theme.of(context).disabledColor;
    shadowColor = Theme.of(context).shadowColor;
    defaultBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    blackWhiteColor = Theme.of(context).cardColor;
    separateColor = Theme.of(context).canvasColor;
    bagwhite = Theme.of(context).primaryColorDark;
  }
}

Color primaryMain = Color(0xFFFF7643);
Color primaryHover = Color(0xffFFDAB9);
Color primaryClick = Color(0xffFF8C00);
Color white = Color(0xffFFFFFF);
Color bagwhite = Colors.black;

// const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);

const kPrimaryGradientColorWhite = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xffFFFFFF), Colors.white70],
);

//  Color shadowColor=
Color errorMain = Color(0xffFF4842);
Color errorHover = Color(0xffFF6D68);
Color errorClick = Color(0xffCC3A35);

Size getSize(BuildContext context) => MediaQuery.of(context).size;
EdgeInsets paddingAll(double size) => EdgeInsets.all(size);
EdgeInsets paddingSymetric({double vertical = 0.0, double horizontal = 0.0}) =>
    EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
EdgeInsets paddingOnly({
  double left = 0.0,
  double top = 0.0,
  double right = 0.0,
  double bottom = 0.0,
}) =>
    EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);

BorderRadius circularBorder = BorderRadius.circular(10);

Widget space = const SizedBox(
  height: 16,
);

BoxShadow boxShadow(BuildContext context) {
  ColorApp().init(context);
  return BoxShadow(
      color: ColorApp.shadowColor,
      blurRadius: 5,
      spreadRadius: 10,
      offset: Offset(5, 5));
}

int defaultTextStyle = 16;
int shadow = 4;

TextStyle onBoardTextStyle(Color c) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w700,
      // height: 0.8,
      fontSize: 53,
    );
TextStyle titleStyle(Color c, {weight = FontWeight.w700}) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: weight,
      // height: 0.64,
      fontSize: 24,
    );
TextStyle supertitleStyle(Color c, {weight = FontWeight.w700}) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: weight,
      // height: 0.8,
      fontSize: 32,
    );
TextStyle subtitleStyle(Color c) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      // height: 0.56,
    );
TextStyle bodyBoldStyle(Color c, {double fontSize = 16}) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      // height: 0.48,
    );
TextStyle bodyStyle(Color c, {double fontSize = 16}) => TextStyle(
    color: c,
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w400,
    fontSize: fontSize,
    // height: 0.48,
    inherit: false);
TextStyle bodyFieldStyle(Color c) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      // textBaseline: TextBaseline.alphabetic
      // height: 15.0
    );
TextStyle bodyLightStyle(Color c, {double fontSize = 16}) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w300,
    fontSize: fontSize,
    // height: 0.48,
    color: c);
TextStyle footnoteStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w300,
    fontSize: 12,
    // height: 0.32,
    color: c);
TextStyle footfilterStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    // height: 0.32,
    color: c);
TextStyle SeetingStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w300,
    fontSize: 16,
    height: 0,
    color: c);
TextStyle overlineStyle(Color c) => TextStyle(
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w600,
      fontSize: 10,
      // height: 0.32,
      color: c,
    );
TextStyle buttonStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    // height: 0.48,
    letterSpacing: 1,
    color: c);
TextStyle linkStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: c);
TextStyle linkFootnoteStyle(Color c) {
  return TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w500,
      fontSize: 12,
      // height: 0.32,
      color: c);
}

Widget customIconButton(context, {Function()? press, required IconData icon}) =>
    GestureDetector(
      onTap: press,
      child: Container(
        padding: paddingAll(10),
        decoration: BoxDecoration(
            borderRadius: circularBorder,
            color: ColorApp.defaultBackgroundColor,
            boxShadow: [boxShadow(context)]),
        child: Icon(
          icon,
          color: ColorApp.blackWhiteColor,
        ),
      ),
    );

Widget alertContainer(
        {context,
        text,
        icon = Icons.warning_sharp,
        color = Colors.yellowAccent}) =>
    Container(
      margin: paddingSymetric(vertical: 24),
      padding: paddingAll(8),
      decoration: BoxDecoration(
        borderRadius: circularBorder,
        color: ColorApp.defaultBackgroundColor,
        border: Border.all(width: 0.5, color: primaryMain),
        // boxShadow [boxShadow(context)]
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          Container(
            width: getSize(context).width / 1.5,
            child: Text(
              text,
              style: footnoteStyle(ColorApp.primaryText),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

Future<void> showAlertDialog(
    {required BuildContext context,
    required String title,
    required String body,
    bool? isError,
    VoidCallback? method}) {
  // ignore: missing_return
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: subtitleStyle((isError != null && isError)
                        ? errorMain
                        : ColorApp.secondaryText),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    body,
                    // maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorApp.secondaryText,
                        fontFamily: 'SignikaNegative',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        inherit: false),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Divider(
                  height: 1,
                  color: ColorApp.secondaryText.withOpacity(0.5),
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        method;
                      },
                      child: Text(
                        "done_text".i18n(),
                        style: buttonStyle(primaryMain),
                      )),
                ),
              ],
            ),
          ),
        );
      });
}

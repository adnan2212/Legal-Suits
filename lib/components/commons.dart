import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legalsuits/globals.dart' as g;

//application title
class TitleText extends StatelessWidget {
  const TitleText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Legal\nSuits",
      style: GoogleFonts.martel(
        textStyle: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 18,
          color: g.primary,
        ),
      ),
    );
  }
}

//TextStyles

//martels
TextStyle caseSubtitle = GoogleFonts.martel(
  fontWeight: FontWeight.w400,
  fontSize: 13,
  color: g.blackfont2,
);

TextStyle caseMoreButton = GoogleFonts.martel(
  fontWeight: FontWeight.w400,
  fontSize: 10,
  color: g.white,
);

TextStyle caseMoreButton2 = GoogleFonts.martel(
  fontWeight: FontWeight.w800,
  fontSize: 15,
  color: g.white,
);

TextStyle hinttextaddcase = GoogleFonts.martel(
  fontWeight: FontWeight.w400,
  fontSize: 18,
  color: g.blackfont2.withOpacity(0.6),
);

TextStyle textaddcase = GoogleFonts.martel(
  fontWeight: FontWeight.w400,
  fontSize: 18,
  color: g.blackfont2,
);

TextStyle hint = GoogleFonts.martel(
  fontWeight: FontWeight.w600,
  fontSize: 18,
  color: g.primary,
);

TextStyle back = GoogleFonts.martel(
  fontWeight: FontWeight.w600,
  fontSize: 15,
  color: Colors.black.withOpacity(0.7),
);

TextStyle catAttPageunselected = GoogleFonts.martel(
  fontWeight: FontWeight.w700,
  fontSize: 12,
  color: g.blackfont2,
);

TextStyle catAttPageuselected = GoogleFonts.martel(
  fontWeight: FontWeight.w700,
  fontSize: 12,
  color: g.white,
);

TextStyle casesubject = GoogleFonts.martel(
  fontWeight: FontWeight.w700,
  fontSize: 16,
  color: g.blackfont2,
);

TextStyle attname = GoogleFonts.martel(
  fontWeight: FontWeight.w800,
  fontSize: 15.43,
  color: g.blackfont2,
);

TextStyle attdetails = GoogleFonts.martel(
  fontWeight: FontWeight.w800,
  fontSize: 12,
  color: g.blackfont2.withOpacity(0.75),
);

TextStyle filtertext = GoogleFonts.martel(
  fontWeight: FontWeight.w800,
  fontSize: 15,
  color: g.blackfont2,
);

TextStyle pagetitle = GoogleFonts.martel(
  fontWeight: FontWeight.w800,
  fontSize: 18,
  color: g.blackfont2,
);

TextStyle buttonText2 = GoogleFonts.martel(
  fontWeight: FontWeight.w900,
  fontSize: 12,
  color: g.white,
);

TextStyle casetitle = GoogleFonts.martel(
  fontWeight: FontWeight.w900,
  fontSize: 18,
  color: g.blackfont2,
);

TextStyle buttonText = GoogleFonts.martel(
  fontWeight: FontWeight.w900,
  fontSize: 18,
  color: g.white,
);

//robotos
TextStyle altblack = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: g.blackfont,
  ),
);

TextStyle subwelcome = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: g.greyfont2,
  ),
);

//poppins
TextStyle tncnonclickable = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 16,
    color: g.blackfont,
  ),
);

TextStyle skip = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 18,
    color: g.greyfont,
  ),
);

TextStyle signupsonselected = GoogleFonts.poppins(
  fontWeight: FontWeight.w300,
  fontSize: 22,
  color: g.blackfont,
);

TextStyle altblue = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: g.bluefont,
  ),
);

TextStyle tncclickable = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: g.bluefont2,
    decoration: TextDecoration.underline,
  ),
);

TextStyle wlcomeback = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 26,
    color: g.blackfont,
  ),
);

TextStyle pagetitle2 = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  fontSize: 22,
  color: g.blackfont,
);

TextStyle signupselected = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  fontSize: 22,
  color: g.bluefont,
);

TextStyle buttontext = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 22,
);

TextStyle catnotselected = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: Colors.black,
  fontSize: 10,
);

TextStyle catselected = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 12,
);

TextStyle lsblue = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: g.bluefont,
  ),
);

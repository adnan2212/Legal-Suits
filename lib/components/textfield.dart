import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/globals.dart' as g;

//logins and signup textfields
class TxtField extends StatefulWidget {
  const TxtField(
      {Key key,
      this.controller,
      this.prefix,
      this.hint,
      this.ispass,
      this.validate})
      : super(key: key);
  final TextEditingController controller;
  final String prefix, hint;
  final bool ispass;
  final Function validate;

  @override
  _TxtFieldState createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  bool obs = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validate,
      controller: widget.controller,
      obscureText: widget.ispass ? obs : false,
      decoration: InputDecoration(
        suffixIcon: widget.ispass
            ? RawMaterialButton(
                child: Icon(obs ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    obs = !obs;
                  });
                })
            : null,
        prefixIcon: Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/${widget.prefix}.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 1.0,
            style: BorderStyle.solid,
            color: g.greyBorder,
          ),
        ),
        hintText: widget.hint,
        hintStyle: GoogleFonts.poppins(
          color: g.greyfont,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: GoogleFonts.poppins(
        color: g.blackfont,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

//textfield for search bar

class SearchField extends StatefulWidget {
  const SearchField({Key key, this.onPressed, this.ctrl}) : super(key: key);
  final Function onPressed;
  final TextEditingController ctrl;

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: g.width * 0.05),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(18),
        color: Colors.transparent,
        child: TextField(
          textInputAction: TextInputAction.search,
          onSubmitted: (str) {
            widget.onPressed();
          },
          controller: widget.ctrl,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(18)),
              hintText: 'Search',
              hintStyle: hint,
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: widget.onPressed,
              )),
        ),
      ),
    );
  }
}

//text field for forms of adding new cases etc.abstract
class AddNewFormField extends StatefulWidget {
  const AddNewFormField(
      {Key key, this.hintText, this.lines, this.validate, this.ctrl})
      : super(key: key);
  final String hintText;
  final int lines;
  final Function validate;
  final TextEditingController ctrl;

  @override
  _AddNewFormFieldState createState() => _AddNewFormFieldState();
}

class _AddNewFormFieldState extends State<AddNewFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: widget.lines,
      maxLines: widget.lines,
      controller: widget.ctrl,
      style: textaddcase,
      validator: widget.validate,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: hinttextaddcase,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: g.greyBorder,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

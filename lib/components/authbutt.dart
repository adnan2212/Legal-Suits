import 'package:flutter/material.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/globals.dart' as g;

//login signup button
class AuthButton extends StatefulWidget {
  const AuthButton({Key key, this.buttonName, this.onPressed})
      : super(key: key);
  final String buttonName;
  final Function onPressed;

  @override
  _AuthButtonState createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RawMaterialButton(
            onPressed: widget.onPressed,
            child: Container(
                height: g.height * 0.0824,
                decoration: BoxDecoration(
                  color: g.bluebg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    widget.buttonName,
                    style: buttonText,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

//add new case, submit button 
class SubmitButton extends StatefulWidget {
  const SubmitButton({Key key, this.buttonName, this.onPressed})
      : super(key: key);
  final String buttonName;
  final Function onPressed;

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: g.width * 0.226,
        right: g.width * 0.226,
        top: 15.0,
        bottom: 20.0,
      ),
      child: RawMaterialButton(
        onPressed: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: g.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Text(
                widget.buttonName,
                style: buttonText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//attorney page related buttons
class AttorneyButton1 extends StatelessWidget {
  const AttorneyButton1({Key key, this.buttonname, this.onpressed})
      : super(key: key);
  final String buttonname;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onpressed,
      child: Container(
        height: g.height * 0.07,
        width: g.width * 0.399,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: g.orangebg,
        ),
        child: Center(
          child: Text(
            buttonname,
            style: buttonText2,
          ),
        ),
      ),
    );
  }
}

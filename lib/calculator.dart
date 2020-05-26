import 'package:calc_app/eval_expression.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = "0";
  String _expression = "0";
  double num1 = 0.0, num2 = 0.0;
  String operand = "";

  _buttonPressed(String btn) {
    if (btn == "C")
      _expression = "0";
    else if (btn == "=") {
      var _lastChar = _expression[_expression.length - 1];

      if (_lastChar == "+" ||
          _lastChar == "-" ||
          _lastChar == "*" ||
          _lastChar == "/")
        _expression = _expression.substring(0, _expression.length - 1);

      var result = evaluate(_expression);

      _expression = result.toString();
    } else if (btn == ".") {
    } else {
      if (btn == "+" || btn == "-" || btn == "*" || btn == "/") {
        var _lastChar =
            _expression.length == 0 ? "" : _expression[_expression.length - 1];

        if (!(_lastChar == "+" ||
            _lastChar == "-" ||
            _lastChar == "*" ||
            _lastChar == "/" ||
            _lastChar == "")) _expression += btn;
      } else {
        if (_expression == "0")
          _expression = btn;
        else
          _expression += btn;
      }
    }

    setState(() {
      displayText = _expression;
    });
  }

  Widget _button(String text,
      {Color fgColor: Colors.white, Color bgColor: Colors.white12}) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      height: 70.0,
      child: Text(text,
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 30.0)),
      textColor: fgColor,
      color: bgColor,
      onPressed: () => _buttonPressed(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(
                height:
                    Theme.of(context).textTheme.display1.fontSize * 1.1 + 100,
              ),
              alignment: Alignment.bottomRight,
              child: Text(
                displayText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.backspace),
                  color: Colors.green,
                  onPressed: () {
                    if (_expression.length != 0)
                      _expression =
                          _expression.substring(0, _expression.length - 1);
                    setState(() {
                      displayText = _expression;
                    });
                  },
                ),
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("9"),
                _button("8"),
                _button("7"),
                _button("+", fgColor: Colors.green),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("6"),
                _button("5"),
                _button("4"),
                _button("-", fgColor: Colors.green),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("3"),
                _button("2"),
                _button("1"),
                _button("*", fgColor: Colors.green),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("C", fgColor: Colors.deepOrange),
                _button("0"),
                _button("=", bgColor: Colors.green),
                _button("/", fgColor: Colors.green),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("(", fgColor: Colors.green),
                _button(")", fgColor: Colors.green),
                _button("."),
                _button("MOD"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

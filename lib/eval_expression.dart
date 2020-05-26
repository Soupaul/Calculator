import 'package:calc_app/stack.dart';

bool isDigit(String ch) {
  return ch.codeUnitAt(0) >= 48 && ch.codeUnitAt(0) <= 57;
}

int precedence(String op) {
  if (op == "+" || op == "-")
    return 1;
  else if (op == "*" || op == "/") return 2;

  return 0;
}

applyOp(int v1, int v2, String op) {
  switch (op) {
    case "+":
      return v1 + v2;
    case "-":
      return v1 - v2;
    case "*":
      return v1 * v2;
    case "/":
      return v1 / v2;
    default: // Not necessarily required.
      return 0;
  }
}

evaluate(String tokens) {
  Stack values = Stack();
  Stack ops = Stack();
  int i;

  for (i = 0; i < tokens.length; i++) {
    if (tokens[i] == " ")
      continue;
    else if (tokens[i] == "(") {
      ops.push(tokens[i]);
    } else if (isDigit(tokens[i])) {
      int val = 0;

      while (i < tokens.length && isDigit(tokens[i])) {
        val = val * 10 + (tokens.codeUnitAt(i) - 48);
        i++;
      }

      values.push(val);
      i--;
    } else if (tokens[i] == ")") {
      while (!ops.isEmpty() && ops.getTop() != "(") {
        int val2 = values.getTop();
        values.pop();

        int val1 = values.getTop();
        values.pop();

        String op = ops.getTop();
        ops.pop();

        values.push(applyOp(val1, val2, op));
      }

      if (!ops.isEmpty()) {
        ops.pop();
      }
    } else {
      while (
          !ops.isEmpty() && precedence(ops.getTop()) >= precedence(tokens[i])) {
        int val2 = values.getTop();
        values.pop();

        int val1 = values.getTop();
        values.pop();

        String op = ops.getTop();
        ops.pop();

        values.push(applyOp(val1, val2, op));
      }
      ops.push(tokens[i]);
    }
  }

  while (!ops.isEmpty()) {
    int val2 = values.getTop();
    values.pop();

    int val1 = values.getTop();
    values.pop();

    String op = ops.getTop();
    ops.pop();

    values.push(applyOp(val1, val2, op));
  }

  return values.getTop();
}

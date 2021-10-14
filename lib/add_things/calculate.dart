import 'dart:math';

add(a, b) => a + b;
subtract(a, b) => a - b;
multiply(a, b) => a * b;
divide(a, b) => a / b;
modulo(a, b) => a % b;
exponent(a, b) => pow(a, b);

const operators = const {
  "+": add,
  "-": subtract,
  "*": multiply,
  "/": divide,
  "%": modulo,
  "^": exponent
};

final RegExp expression = new RegExp(
    r"(\d+\.\d+|\d+)(?:\s*)(\+|\-|\*|\/|\%|\^*)(?:\s*)(\d+\.\d+|\d+)");
final RegExp parens = new RegExp(r"\((.*)\)");

calculate(String input) {
  if (!expression.hasMatch(input)) {
    throw new Exception("Invalid Input");
  }

  var expr = input;

  expr = expr.replaceAllMapped(parens, (match) => calculate(match[1]!));

  while (expression.hasMatch(expr) && num.parse(expr, (s) => null) == null) {
    var match = expression.firstMatch(expr);
    var left = num.parse(match![1]!);
    var op = match[2]!;
    var right = num.parse(match[3]!);

    expr = expr.replaceAll(match[0]!, operators[op]!(left, right).toString());
  }

  return expr;
}

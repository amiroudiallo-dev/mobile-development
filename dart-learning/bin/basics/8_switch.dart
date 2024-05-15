

void main() {

  var x = 5;
  var y = 34;

  var op = '';

  switch(op) {
    case '+':
      print('x + y = ${x + y}');
      break;
    case '-':
      print('x + y = ${x - y}');
      break;
    case '*':
      print('x * y = ${x * y}');
      break;
    case '/':
      print('x / y = ${x / y}');
      break;
    case '%':
      print('x % y = ${x % y}');
    default:
      print('Not valid operation.');
  }
}
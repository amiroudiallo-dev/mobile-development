import 'dart:io';

class MathQuestion {
  final String question;
  final double answer;

  MathQuestion({
    required this.question, 
    required this.answer
  });
}

double getAnswer(String q) {
  print('*** Answer to question ***');
  print('Q// $q');
  var answer = double.tryParse(stdin.readLineSync()!) ?? 0.00;
  return answer;
}

void main() {

  var questions = [
    MathQuestion(question: '4 + 5', answer: 9.0),
    MathQuestion(question: '8 * 100', answer: 8000.0),
    MathQuestion(question: '8 - 4', answer: 4.0),
  ];
  
  for (var item in questions) {
    var userAnswer = getAnswer(item.question);
    print('Your answer is $userAnswer');

    if (userAnswer == item.answer) {
      print('Correct answer!');
    } else {
      print('Incorrect answer, the answer was ${item.answer}');
    }
    print('------------');
  }
  
}


void main() {

  Human h1 = Human('Hassan', 20, 170.5);
  print('------');
  Human h2 = Human('Ali', 15, 160);
  print('------');
}


class Human {

  var name, age, height;

// constructor
  Human(String name, int age, double height) {
    this.name = name;
    this.age = age;
    this.height = height;

    print('Name = $name');

    age += 5;
    print('Age = $age');
    print('Heigth = $height');
  }

}
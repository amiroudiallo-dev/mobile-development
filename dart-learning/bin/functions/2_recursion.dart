

void main() {
  print(fact(3));

}


int fact(n) {
  if (n != 0) {
    return  n + fact(n -1);
  } else {
    return 0;
  }
}
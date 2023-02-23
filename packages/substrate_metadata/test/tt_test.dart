void main() {
  List<A> list = [
    A(0),
    A(1),
    A(2),
    A(3),
    A(4),
    A(5),
    A(10),
    A(17),
    A(18),
    A(19),
    A(21),
  ];

  final int blockNumber = 22;

  int prev = -1;
  int next = list.length;
  int mid = (list.length / 2).floor();
  int iterations = 0;
  // do this with merge sort
  while (true) {
    iterations++;
    if (list[mid].blockNumber == blockNumber) {
      print('found');
      break;
    } else if (list[mid].blockNumber > blockNumber) {
      next = mid;
      print('look into left: $mid');
      mid = (prev + mid) ~/ 2;
    } else {
      prev = mid;
      print('look into right: $mid');
      mid = (mid + next) ~/ 2;
    }
    if (mid == prev) {
      print('not found');
      mid = prev;
      break;
    }
    if (mid == next) {
      print('not found');
      mid = next;
      break;
    }
  }
  print('iterations: $iterations');
  print('mid: $mid');
}

class A {
  final int blockNumber;
  const A(this.blockNumber);
}

class Stack {
  int top;
  List st;

  Stack() {
    top = -1;
    st = [];
  }

  void push(var item) {
    top++;
    st.add(item);
  }

  void pop() {
    if (st.length != 0) {
      st.removeAt(top);
      top--;
    }
  }

  getTop() {
    return st[top];
  }

  bool isEmpty() {
    return st.length == 0;
  }

  void display() {
    st.forEach((item) {
      print(item);
    });
  }
}

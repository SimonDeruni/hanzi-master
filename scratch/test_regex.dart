void main() {
  try {
    print('我喜欢喝苹果汁。'.replaceAll(RegExp(r'[^\p{Script=Han}a-zA-Z0-9 ]', unicode: true), ''));
    print('Testing Hani script:'.replaceAll(RegExp(r'[^\p{Script=Hani}a-zA-Z0-9 ]', unicode: true), ''));
  } catch(e) {
    print(e);
  }
}

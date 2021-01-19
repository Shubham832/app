//tests for authentication occurs
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:imbuedesk_project/services/auth.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUser,
    ]);
  }
}

//Tests for emission and creation
void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final Auth auth = Auth(auth: mockFirebaseAuth);
  setUp(() {});
  tearDown(() {});

  test("emit occurs", () async {
    expectLater(auth.user, emitsInOrder([_mockUser]));
  });

  test("create account", () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
          email: "shubhamraj@gmail.com", password: "qwerty123"),
    ).thenAnswer((realInvocation) => null);

    expect(
        await auth.createAccount(
            email: "shubhamraj@gmail.com", password: "qwerty123"),
        "Success");
  });

  test("create account exception", () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
          email: "shubhamraj@gmail.com", password: "qwerty123"),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "Some error has occured"));

    expect(
        await auth.createAccount(
            email: "shubhamraj@gmail.com", password: "qwerty123"),
        "Some error has occured");
  });

//Tests for sign in and exceptions
  test("sign in", () async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
          email: "shubhamraj@gmail.com", password: "qwerty123"),
    ).thenAnswer((realInvocation) => null);

    expect(
        await auth.signIn(email: "shubhamraj@gmail.com", password: "qwerty123"),
        "Success");
  });

  test("sign in exception", () async {
    when(
      mockFirebaseAuth.signInWithEmailAndPassword(
          email: "shubhamraj@gmail.com", password: "qwerty123"),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "Some error has occured"));

    expect(
        await auth.signIn(email: "shubhamraj@gmail.com", password: "qwerty123"),
        "Some error has occured");
  });

//Tests for sign out and exceptions
  test("sign out", () async {
    when(
      mockFirebaseAuth.signOut(),
    ).thenAnswer((realInvocation) => null);

    expect(await auth.signOut(), "Success");
  });

  test("sign out exception", () async {
    when(
      mockFirebaseAuth.signOut(),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "Some error has occured"));

    expect(await auth.signOut(), "Some error has occured");
  });
}

// Integration testing is done here
//Here, it will create an account with a given email and password, and logs in and signs out
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Todo App', () {
    final usernameField = find.byValueKey('UserName');
    final passwordField = find.byValueKey('Password');
    final signInButton = find.byValueKey('SignIn');
    final createAccountButton = find.byValueKey('CreateAccount');

    final signOutButton = find.byValueKey('SignOut');
    final addField = find.byValueKey('AddField');
    final addButton = find.byValueKey('AddButton');

    FlutterDriver driver;

    Future<bool> isPresent(SerializableFinder byValueKey,
        {Duration timeout = const Duration(seconds: 1)}) async {
      try {
        await driver.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

//Creating account
    test('create account', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(usernameField);
      await driver.enterText("shubhamraj@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("qwerty123");

      await driver.tap(createAccountButton);
      await driver.waitFor(find.text("Your Todos"));
    });

//Login
    test('login', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(signOutButton);
      }

      await driver.tap(usernameField);
      await driver.enterText("shubhamraj@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("qwerty123");

      await driver.tap(signInButton);
      await driver.waitFor(find.text("Your Todos"));
    });

//Add a todo
    test('add a todo', () async {
      if (await isPresent(signOutButton)) {
        await driver.tap(addField);
        await driver.enterText("Task A");
        await driver.tap(addButton);

        await driver.waitFor(find.text("Task A"),
            timeout: const Duration(seconds: 3));
      }
    });
  });
}

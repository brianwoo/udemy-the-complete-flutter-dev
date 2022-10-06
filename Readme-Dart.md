# main()
- Entry point for a dart program

<br>

# Variables
```dart
void main() {
    var name = "John";
    print(name);

    String lastname = "Smith";
    print(lastname);
}
```
<br>

# Data Types
- Numbers - int & double (floating point value), ** NO long and float**
- Boolean - bool
- Strings - a string is enclosed in single or double quotes
- Lists   - List, same as array in other prog langs
- Maps    - Map


## Strings
### Concat strings
```dart
String firstName = "John";
String lastName = "Smith";

String fullName = firstName + " " + lastName;

// String interpolation
String fullName = "$firstName $lastName";

String teslaModel = 'Model ${1+2}';
```

## Common String properties and methods
```dart
String name = "John Smith";

name.length;
name.isEmpty;
name.toUpperCase();
name.trim();
name.substring(5);     // Smith
name.substring(5,9);   // Smit  index 9 - exclusive
name.split(" ");       // ["John", "Smith"]
```

## Numbers
- Integer (int - 64bit)
- Floating-Point Number (double - 64bit)
- Number (num - means integer or double)

```dart
int num1 = 10;
double num2 = 10.56;
var num3 = num1 + num1;  // num3 is an int, 20
var num3 = num1 + num2;  // num3 is a double, 20.56

```

### Convert between String and Number
```dart
var num2 = num.parse('300');    // Convert string "300" to a number
var num2 = num.parse("300.56"); // Convert string "300.56" to a double

int number4 = 101;
number4.toString();             // Convert 101 to "101"

```

### Common Number properties and methods
```dart
double number3 = 100.4;
double number4 = 100.5;
number4.isNaN;
number4.isNegative;
number4.sign;        // 0, 1 means +ve, -1 means -ve.

number4.toInt();     // convert double to int, 100
int number5 = 5;
number5.toDouble();  // convert int to double, 5.00

int number6 = -5;
number6.abs();       // absolute value, 5

number3.round();     // normal math rounding, 100
number4.round();     // normal math rounding, 101

number3.ceil();      // round up, 101

```
<br>

## Maps
- key, value pairs
- instantiated using literals or constructor
```dart
void main() {

  // Map literal
  var cars = {"Tesla": "EV", "Toyota": "Gas"};
  print(cars["Toyota"]);
  
  // Map constructor
  var fruits = Map();
  fruits["Apple"] = "Red";
}
```
<br>

## Lists
- Like arrays in other languages
```dart
void main() {

  // list literal (not fixed size)
  var list1 = ["A","B","C","D"];
  print(list1[1]); // "B"
  list1.add("E");
  print(list1);  // [A, B, C, D, E]
  
  // Map with filled constructor
  var list2 = List.filled(3, "0", growable: true);
  list2[0] = "1";
}
```
<br>

## Final vs Const
- final - runtime constants
- const - compile time constants
<br>
<br>

# Functions
- Dart supports position args and named args
- Named args always AFTER position args
- Named args are Optional

```dart
void main() {
  printToConsole("pos1", nameArg1: "name1");
  printToConsole("pos1", nameArg2: "name2");
  printToConsole("pos1", nameArg1: "name1", nameArg2: "name2");
}

void printToConsole(String posArg1, {String? nameArg1, String? nameArg2}) {
    ...
}
```
<br>

# Conditional
- if, else if, else
- switch

```dart
void main() {
    bool condition1 = true;
    bool condition2 = true;
    if (condition1 && condition2) {
        ...
    }
    else if (condition1) {
        ...
    }
    else {
        ...
    }

    String breakfastChoice1 = "Eggs";
    switch(breakfastChoice1) {
        case "Eggs": 
            ...
            break;
        case "Cereal":
            ...
            break;
        default:
            ...
    }
}
```
<br>

# Loops
- for
- for in
- while
- do while

```dart
// for loop
for (int i = 0; i < 10; i++) {
    ...
}

// for in loop
var list1 = ["A", "B", "C", "D"];
for (var char in list1) {
    ...
}

// while loop
int x = 0;
while(x < 10) {
    print(x);
    x++;
}

// do while
int y = 0;
do {
    print(y);
    y += 1;
} while (y < 10);
```
<br>

# Class & Objects
```dart
void main() {
  
  // Dart does not need "new" Clazz() anymore
  Vehicle vehicle = Vehicle("V6");
  vehicle.display();

  Truck truck = Truck("V8", 4);
  truck.display();
  truck.numWheels;  // use getter
  
  MotorBike mBike = MotorBike();
  mBike.display();
  
  SlowCar sCar = SlowCar("V2");
  sCar.display();
}

class Vehicle {
    String engine;
 
  // Shorter way of doing a constructor with an arg
    Vehicle(this.engine);
  
  //   Short constructor but with initializing code
  //   Car(this.engine) {
  //     ...
  //   }
  
  //   The traditional way of doing constructor 
  //   with an arg
  //   Car(String engine) {
  //     this.engine = engine;
  //   }

    void display() {
        print(engine);
    }
}

class Truck extends Vehicle {
  final int _numWheels; // private
  
  Truck(super.engine, this._numWheels);
  
  int get numWheels {  // getter
    return _numWheels;
  }  
}

class MotorBike extends Vehicle {  
  MotorBike(): super("V1");  
}

class SlowCar extends Vehicle {
  SlowCar(String engine): super(engine);
}
```
<br>

# Factory constructor
- It's like using a static method to construct an object instance
```dart
class Dog {

  factory Dog.createDog(...) {
    return Doberman();
  }
}

class Doberman extends Dog {
  ...
}

class Labrador extends Dog {
  ...
}
```

<br>

# Async / Await
- An Async function always runs in the background (asynchronously)
- An Async function always return a Future (need async keyword)
- To wait for a async function to finish, we need to use await keyword
```dart
void main() async {
  // The following statements don't run in an order
  await futureFunction1();
  print("After futureFunction1");
  
  // The following statements run one after another
  await futureFunction2();
  print("After futureFunction2");
}


Future futureFunction2() async {
  // With await, it blocks until async function
  // finishes before returning
  await Future.delayed(Duration(seconds: 2))
    .whenComplete(() => print("Delay 2 done"));
}

Future futureFunction1() async {
  // *** BE CAREFUL ***:
  // If we DON'T put await in front of an async function,
  // it returns right away, because it executes asynchronously.
  Future.delayed(Duration(seconds: 4))
    .whenComplete(() => print("Delay 1 done"));
}

// Output:
After futureFunction1
Delay 2 done
After futureFunction2
Delay 1 done

```
<br>

# Optional Chaining(?) and Non-null Assertion(!)
```dart
class Person {
  late String name;
  PersonProperty? personProperty;
  
}

class PersonProperty {
  String? optionalProperty;
}


void main() {

  /* 
  Conditional Property Access 
  Similar to "Optional chaining operator" in JS 
  */
  Person person = Person();
  print(person.personProperty?.optionalProperty); // null
  
  Person? person2;
  // person2 can be null. Accessing person2.personProperty
  // can cause an exception. With person2?.personProperty,
  // it would return null, instead of an exception being 
  // thrown.
  print(person2?.personProperty?.optionalProperty); // null
    
  /*
  Non-null assertion operator
  Similar to Typescript's
  */
  // person2 can be null but we use person2! to 
  // tell the compiler that we are SURE that person2 
  // is not null.
  print(person2!.personProperty?.optionalProperty); // uncaught exception

  print(person.personProperty!.optionalProperty); // uncaught exception
}

```
<br>

# Cascades (..) and null-shorting cascade (?..)
- myObject..someMethod()
  - it invokes someMethod() on myObject
  - but return a reference to myObject, not result of someMethod()
  
```dart
/* 
Using cascades, you can chain together operations that would otherwise require separate statements. For example, consider the following code, which uses the conditional member access operator (?.) to read properties of button if it isn’t null:
*/

var button = querySelector('#confirm');
button?.text = 'Confirm';
button?.classes.add('important');
button?.onClick.listen((e) => window.alert('Confirmed!'));
button?.scrollIntoView();

/*
To instead use cascades, you can start with the null-shorting cascade (?..), which guarantees that none of the cascade operations are attempted on a null object. Using cascades shortens the code and makes the button variable unnecessary:
*/

querySelector('#confirm')
  ?..text = 'Confirm'
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'))
  ..scrollIntoView();
```
<br>

# Null Safety
- Protection at compile time
- All variables can be SET nullable (even int)
- With Null Safety built-in, a variable by default is NOT nullable, unless we tell Dart it can be null
- To tell Dart to set a variable nullable, use ? or late keyword to tell Dart a value is being assigned later

```dart
void main() {
  String? name;    // name can be null
  print(name);
    
  // String nickName; // error because it can be null (need ?)
  // print(nickName);
    
  // we tell dart that specialName will be assigned later.
  late final String specialName; 
  specialName = "special";
  
  Car? car;
  print(car!.name);  // ! - assertion op - tell dart we're sure car is not null
}

class Car {
  late final String name;
  
  Car(this.name);
}
```
<br>

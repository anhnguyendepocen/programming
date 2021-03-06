//============================================================================
// Name        : cpp11.cpp
// Author      : Ethen
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <typeinfo>  // typeid
#include <vector>
#include <initializer_list>
#include "ring.h"
using namespace std;

int get() {
	return 999;
}

// if we declare functions as auto return type,
// then we have to have a trailing type, and
// we can put expressions in decltype to declare that
auto test2() -> decltype(get()) {
	return get();
}


// initializer list
class Test {
public:
	// initializer_list is a template
	Test(initializer_list<string> texts) {
		cout << "initializer list: " << endl;
		// loop through the iterable
		for (auto text: texts) {
			cout << text << endl;
		}
	}

	void print(initializer_list<string> texts) {
		for (auto text: texts) {
			cout << text << endl;
		}
	}
};


class Testing {
private:
	// we can specify default values in cpp11
	int id = 3;
	string name = "Mike";

public:

	Testing() {
		// equivalent to Testing() = default;
	}

	// we can use the default keyword to specify that we do wish
	// to keep the default copy constructor
	Testing(const Testing &other) = default;

	Testing(int id): id(id) {

	}

	void print() {
		cout << id << ": " << name << endl;
	}
};


void lambda_func(void (*pfunc)()) {
	pfunc();
}


class Testing1 {
private:
	int one = 1;
	int two = 2;

public:
	void run() {
		// capture this to modify private instances;
		// note that this is pass by reference
		auto lambda = [this](){
			cout << "capturing this" << endl;
			one = 5;
			cout << one << ": " << two << endl;
		};
		lambda();
	}
};

int main() {
	// the typeid will return "i" indicating an integer;
	// note that the name can be mingled a bit (e.g. we
	// can try it for string type)
	int value;
	cout << typeid(value).name() << endl;

	// declare the type using the type of the input argument;
	// so we can use it to declare a variable using an existing type
	// that we've used in the program
	decltype(value) value1;
	value1 = 3;
	cout << value1 << endl;


	// we can declare the type as "auto" to let cpp itself figure out the type
	auto value2 = 7;
	cout << value2 << endl;
	cout << test2() << endl;


	// range base for loops
	string texts[] = {"one", "two", "three"};
	for (auto text: texts) {
		cout << text << flush;
	}
	cout << endl;

	vector<int> numbers = {1, 2, 3};
	for (auto num: numbers) {
		cout << num << flush;
	}
	cout << endl;


	cout << endl;
	cout << "ring buffer" << endl;
	ring<string> textring(3);
	textring.add("one");
	textring.add("two");
	textring.add("three");
	textring.add("four");

	for (int i = 0; i < textring.size(); i++) {
		cout << textring.get(i) << flush;
	}
	cout << endl;

	for (auto value: textring) {
		cout << value << flush;
	}
	cout << endl;


	// initialization
	int nvalues[] = {1, 2, 3};
	cout << nvalues[0] << endl;

	// immediately initialize the struct after declaration
	struct S {
		string text;
		int id;
	} s1 = {"Hello", 1};
	cout << s1.text << endl;

	// the following two statement are equivalent,
	// initialization using the bracket syntax {}
	int* pSomething1 = nullptr;
	int* pSomething2{nullptr};

	// enabling initializer list with our own class
	vector<string> strings = {"one", "two", "three"};
	cout << strings[0] << endl;

	// the constructor and method can both take an initializer_list
	Test t{"one", "two", "three"};
	t.print({"apple", "orange"});


	// testing
	Testing testing(77);
	testing.print();


	// lambda expression,
	// use the [] to declare that it's a lambda function,
	// and we can pass it like a function pointer
	auto pfunc = [](){cout << "lambda expression" << endl;};
	lambda_func(pfunc);


	// lambda capture expression
	int one = 1, two = 2, three = 3;

	// capture the variables by value so we can use them in the lambda expression
	[one, two](){cout << one << ": " << two << endl;}();

	// capture every local variable by value, but capture three by reference so
	// we can modify them in the lambda expression
	[=, &three](){three = 7; cout << one << ": " << two << endl;}();
	cout << three << endl;

	// review of constructor concepts
	Testing1 testing1;
	testing1.run();


	// copy elision and return optimization

	return 0;
}

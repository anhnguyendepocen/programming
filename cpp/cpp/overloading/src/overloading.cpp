//============================================================================
// Name        : overloading.cpp
// Author      : Ethen
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include "Complex.h"
using namespace std;
using namespace basics;


class Test {
private:
	int id;
	string name;

public:
	Test(): id(0), name("") {

	}

	Test(int id, string name): id(id), name(name) {

	}

	void print() {
		cout << id << ": " << name << endl;
	}

	const Test &operator=(const Test &other) {
		id = other.id;
		name = other.name;
		// dereference the pointer, which is a pointer
		// to the object itself
		return *this;
	}

	// 1. the ostream object is passed as a reference so we don't
	// have to copy the entire ostream object
	// 2. a friend function of the class is defined outside the class scope,
	// but it has the right to access all the private members of the class.
	// Even though it looks like the friend function appears in the class
	// definition, friends are not member functions
	// https://www.tutorialspoint.com/cplusplus/cpp_friend_functions.htm
	// 3. after overloading the left stream operator, we can get rid of
	// our methods that does the printing
	friend ostream &operator<<(ostream &out, const Test &test) {
		out << test.id << ": " << test.name;
		return out;
	}
};


int main() {
	Test test1(10, "Mike");
	test1.print();

	// by default, cpp provides a shallow copy;
	// when we do the "=" sign operator
	Test test2(20, "Bob");
	test2 = test1;
	test2.print();

	// the following two statement are equivalent
	cout << test2 << endl;
	operator<<(cout, test2) << endl;


	// Complex numbers
	cout << "Complex numbers" << endl;
	Complex c1(2, 5);
	cout << c1 << endl;
	Complex c2(3, 2);
	cout << c1 + c2 << endl;

	if (c1 == c2) {
		cout << "Equal" << endl;
	} else {
		cout << "Not Equal" << endl;
	}

	return 0;
}

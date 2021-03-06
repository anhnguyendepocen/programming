//============================================================================
// Name        : Templates.cpp
// Author      : Ethen
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <vector>
using namespace std;


// for templates, define all the definition and actual implementation
// in the header files

// after defining the class T, T is now a generic type that we can use
template<class T>
class Test {
	// assume that the operator is implemented correctly for the type
	// that the user passed in;
	// Note that when defining template, it's bad practice to interrogate
	// what kind of methods that class has and call it when it has them
private:
	T obj;

public:
	Test(T obj) {
		this->obj = obj;
	}

	void print() {
		cout << obj << endl;
	}
};


// we can also have template functions and
// the typename and class keyword in the template definition
// and be used interchangeably
template<typename T>
void print(T n) {
	cout << "Template version: " << n << endl;
}

void print(int n) {
	cout << "Non-Template version: " << n << endl;
}


// function pointers
void test1() {
	cout << "Hello" << endl;
}

void test2(int value) {
	cout << value << endl;
}

bool match(string value) {
	return value.size() == 3;
}

int countString(vector<string> &texts, bool (*match)(string value)) {
	// function pointers allows us to pass a chunk of code to another function
	int counter = 0;
	for (int i = 0; i < texts.size(); i++) {
		if (match(texts[i])) {
			counter++;
		}
	}
	return counter;
}

int main() {
	Test<string> test("Hello1");
	test.print();

	print<string>("Hello2");
	// the print function that explicitly says it accepts an integer type
	// will be a better match than the template version
	print(5);

	// explicitly include the angle bracket with the type to consider the template version
	print<int>(6);

	test1();

	// function pointer;
	// a variable called pTest that is a function pointer
	// that accepts no argument and has the return type of void
	void (*pTest)();

	// then we can pass the address of the function to the pointer
	// dereference the pointer and call it
	pTest = &test1;
	(*pTest)();

	// but instead of using the syntax above, we can do it like this:
	// the name of the function is essentially a pointer to the function,
	// and when we call the function, it is actually dereferencing it
	pTest = test1;
	pTest();

	// initialize the function pointer directly
	// note that the argument type is mandatory, but
	// the argument name is optional
	void (*pTest2)(int value) = test2;
	pTest2(3);

	vector<string> texts1;
	texts1.push_back("two");
	texts1.push_back("five");
	cout << countString(texts1, match) << endl;
	return 0;
}

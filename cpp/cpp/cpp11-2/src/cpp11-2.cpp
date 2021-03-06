//============================================================================
// Name        : cpp11-2.cpp
// Author      : Ethen
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <vector>
#include <functional>  // function
#include <memory>
using namespace std;

bool check2(string &text) {
	return text.size() == 3;
}

struct check3 {
	bool operator()(string &text) {
		return text.size() == 3;
	}
};

void run(function<bool(string &)> check) {
	// the input is a function that returns a boolean
	// and expects a reference that's a string type
	string test = "dog";
	cout << check(test) << endl;
}


// reviewing concept
class Parent {
private:
	int dogs;
	string text;

public:
	// whenever we define our own constructor for a class;
	// we lose the default constructor (constructor that has no parameters);
	// and the default constructor is needed here because the child class will
	// run it by default, or we need to specify in the child class what constructor
	// to call
	Parent(string text) {
		dogs = 6;
		this->text = text;
		cout << "parent constructor" << endl;
	}
};

class Child: public Parent {
public:
	// specify which constructor to call in the parent class
	Child(): Parent("hello") {

	}
};



class Test {
private:
	static const int size = 100;
	int *_p_buffer = nullptr;

public:
	Test() {
		// constructor
		_p_buffer = new int[size];
		memset(_p_buffer, 0, sizeof(int) * size);
	}

	Test(int i) {
		// parameter constructor

		// does some random stuff with the input argument
		_p_buffer = new int[size];
		for (int i = 0; i < size; i++) {
			_p_buffer[i] = 7 * i;
		}
	}

	// cpp98, there's the rule of three;
	// meaning when we need to implement one of
	// - destructor
	// - copy constructor
	// - copy assignment operator
	// for a class, then we probably need to implement the other two
	// as well. This is because these three special methods have default
	// implementations provided by the compiler, but those implementations
	// are not correct in some cases - most obviously when the class has
	// dynamically allocated data held in a raw pointer or array, like here.
	Test(const Test &other) {
		// copy constructor
		_p_buffer = new int[size];
		memcpy(_p_buffer, other._p_buffer, sizeof(int) * size);
	}

	Test &operator=(const Test &other) {
		// better implementation of the assignment operator
		// safe-guard way of implementing the assignment operator
		// to prevent memory leaks
		cout << "assignment operator" << endl;

		// calls copy constructor
		Test temp(other);

		// Swap our data members with temp,
		swap(*this, temp);

		// after this step our data member contains the correct value
		// and the temp object data member's value is set to the value
		// that we no longer require. This ensures new memory is allocated
		// in the constructor or the copy constructor and the destructor handles
		// deleting the memory and the assignment operator only has to take care
		// of the swapping value without having to check for memory leaks

		// calls temp' destructor
		return *this;
	}

	friend void swap(Test& lhs, Test& rhs) {
		// we do not swap over size, as it is a static variable,
		// i.e. not a member variable of the class
		std::swap(lhs._p_buffer, rhs._p_buffer);
	}

	~Test() {
		// destructor
		delete [] _p_buffer;
	}

	friend ostream &operator<<(ostream &out, const Test &test) {
		cout << "hello from Test" << endl;
		return out;
	}

	Test(Test &&other) {
		// move constructor
		cout << "move constructor" << endl;

		// copy the pointer from the other object
		_p_buffer = other._p_buffer;

		// release the pointer from the old object so it does not
		// delete the memory multiple times
		other._p_buffer = nullptr;
	}

	Test &operator=(Test &&other) {
		// move assignment
		// remember to delete any existing pointer
		delete [] _p_buffer;
		_p_buffer = other._p_buffer;
		other._p_buffer = nullptr;
		return *this;
	}
};


Test getTest() {
	// mimick a function that returns a Test object
	return Test();
}


void check_value(const Test &lvalue) {
	cout << "lvalue" << endl;
}

void check_value(Test &&rvalue) {
	cout << "rvalue" << endl;
}

int main() {
	int size = 3;
	vector<string> vec{"one", "two", "three"};

	// count_if:
	// Returns the number of elements in the range [first, last) satisfying specific criteria
	// the last argument accepts anything that's a callable

	// 1. using lambda
	auto check1 = [size](string text){return text.size() == size;};
	int count = count_if(vec.begin(), vec.end(), check1);
	cout << count << endl;

	// 2. using functions
	count = count_if(vec.begin(), vec.end(), check2);
	cout << count << endl;

	// 3. using functors
	check3 check3_test;
	count = count_if(vec.begin(), vec.end(), check3_test);
	cout << count << endl;

	// function type
	run(check1);

	// review concept: child class will class the default
	// parent constructor unless we specify another constructor
	Child child;

	cout << "lvalue & rvalue" << endl;
	// lvalue: anything you can take the address of

	// as we expect, value is a lvalue and 7 is a rvalue
	// base on which side it resides in the equal sign
	int value = 7;

	// value is also a lvalue base on the definition in the
	// beginning of this section
	int* pValue = &value;

	// we can also use prefix
	pValue = &++value;
	// note that postfix increment will not work because
	// the canonical implementation of postfix is to:
	// 1. make a copy of the value
	// 2. increment the value
	// 3. return the copied/old value
	// so the postfix operation won't work since it's returning
	// a temporary copy
	cout << *pValue << endl;

	// we can't take the address of rvalue, e.g. value returned
	// from function, expressions on the fly (value + 8)

	// we can pass lvalue to a reference rvalue
	Test test1;
	Test &test2 = test1;

	// we can also pass a rvalue to a constant rvalue, because
	// the lifetime of the temporary return object has been extended
	const Test &test3 = getTest();
	check_value(test1);

	// rvalue reference with a double ampersand &&
	check_value(getTest());

	cout << test2 << endl;


	// move constructor and assignment to prevent copying
	vector<Test> vec1;
	vec1.push_back(Test());
	return 0;
}

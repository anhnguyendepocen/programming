/*
 * Complex.h
 *
 *  Created on: Sep 8, 2017
 *      Author: ethen
 */

#ifndef COMPLEX_H_
#define COMPLEX_H_

#include<iostream>
using namespace std;

namespace basics {

class Complex {
private:
	double real;
	double imaginary;

public:
	// constructor
	Complex();
	Complex(double real, double imaginary);

	// copy constructor
	Complex(const Complex &other);

	// overload assignment operator
	const Complex &operator=(const Complex &other);

	// overload output stream operator
	friend ostream &operator<<(ostream &out, const Complex &complex);
	friend Complex operator+(const Complex &complex1, const Complex &complex2);
	bool operator==(const Complex &other) const;
	bool operator!=(const Complex &other) const;
	virtual ~Complex();
};

} /* namespace basics */

#endif /* COMPLEX_H_ */

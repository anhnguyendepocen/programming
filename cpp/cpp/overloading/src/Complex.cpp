/*
 * Complex.cpp
 *
 *  Created on: Sep 8, 2017
 *      Author: ethen
 */

#include "Complex.h"

namespace basics {

Complex::Complex(): real(0.0), imaginary(0.0) {
}

Complex::Complex(double real, double imaginary) {
	this->real = real;
	this->imaginary = imaginary;
}

Complex::Complex(const Complex &other) {
	// We can access private members of a class from within the class
	// even those of another instance.
	real = other.real;
	imaginary = other.imaginary;
}

const Complex &Complex::operator=(const Complex &other) {
	real = other.real;
	imaginary = other.imaginary;
	// dereference the pointer, which is a pointer
	// to the object itself
	return *this;
}

ostream &operator<<(ostream &out, const Complex &complex) {
	out << "(" << complex.real << ", " << complex.imaginary << ")";
	return out;
}

Complex operator+(const Complex &complex1, const Complex &complex2) {
	return Complex(complex1.real + complex2.real, complex1.imaginary + complex2.imaginary);
}

bool Complex::operator==(const Complex &other) const {
	return (real == other.real) && (imaginary == other.imaginary);
}

bool Complex::operator!=(const Complex &other) const {
	return !(*this == other);
}

Complex::~Complex() {
	// TODO Auto-generated destructor stub
}

} /* namespace basics */

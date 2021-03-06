//============================================================================
// Name        : Files.cpp
// Author      : Ethen
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <fstream>
using namespace std;


// we can't use string to write to binary file
// (we won't be storing the actual text they store,
// because they're stored somewhere else)

#pragma pack(push, 1) // exact fit - no padding
struct Person {
	// by default struct will have paddings to make them easier to work with
	// we can print the sizeof(struct) to see that the number of bytes does not
	// equal to the bytes that are allocated to each of the members
	// http://www.cplusplus.com/forum/general/14659/
	char name[50];  // 50 bytes
	int age;  // 4 bytes
	double height;  // 8 bytes
};
#pragma pack(pop)


int main() {
	cout << sizeof(Person) << endl;

	Person someone = {"Frodo", "220", "0.8"};
	string fileName = "test.bin";
	ofstream outputFile;
	outputFile.open(fileName, ios::binary);
	if (outputFile.is_open()) {
		outputFile.close();
	} else {
		cout << "can't open file: " << fileName << endl;
	}

	ofstream outFile;
	string outFileName = "text.txt";
	outFile.open(outFileName);
	if (outFile.is_open()) {
		// use .write method when writing to a binary
		// https://stackoverflow.com/questions/4329835/whats-the-difference-between-ofstream-and-write
		// outFile.write((char*)&someone, sizeof(Person));
		outFile.write(reinterpret_cast<char *>(&someone), sizeof(Person));
		outFile.close();
	} else {
		cout << "can't open file: " << outFileName << endl;
	}

	ifstream inFile;
	string inFileName = "text.txt";
	inFile.open(inFileName);
	if (inFile.is_open()) {
		string line;
		// inFile has some useful overloaded operators (more on this in
		// the future), so instead of the following line of code
		// while (!inFile.eof()) {

		// we can instead write the following, because the bool operator
		// has been overloaded
		while (inFile) {
			// reading line by line from the input file while it
			// has not reached the end of file
			getline(inFile, line);
			cout << line << endl;
		}
		inFile.close();
	}

	ifstream input;
	string filename = "stats.txt";
	input.open(filename);
	if (input.is_open()) {
		string line;
		int population;
		while (input) {
			// getline from the input into the string we declared called "line"
			// with the delimiter, getline will read up to the delimiter and the
			// delimiter will be thrown away
			getline(input, line, ':');
			input >> population;

			// read in the extra white space and simply discard it
			input >> ws;

			// if the input is in an error state, break out of the reading loop
			if (!input) {
				break;
			}
			cout <<  "'" << line << "---" << population << "'" << endl;
		}
		input.close();
	}

	return 0;
}

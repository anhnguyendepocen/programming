/*
 * ring.h
 *
 *  Created on: Sep 10, 2017
 *      Author: ethen
 */

#ifndef RING_H_
#define RING_H_

#include <iostream>
using namespace std;

template<typename T>
class ring {
private:
	int m_pos;
	int m_size;
	T *m_values;

public:
	ring(int size): m_pos(0), m_size(size), m_values(NULL) {
		m_values = new T[size];
	}

	~ring() {
		delete[] m_values;
	}

	int size() {
		return m_size;
	}

	void add(T value) {
		m_values[m_pos] = value;
		m_pos++;
		if (m_pos == m_size) {
			m_pos = 0;
		}
	}

	T &get(int pos) {
		return m_values[pos];
	}
	// define the class iterator here
	class iterator;

	// begin of the iterator points to the begin
	// and end points off bounds, then we also
	// dereference the object so the iterator can
	// actually access the class's private information
	iterator begin() {
		return iterator(0, *this);
	}

	iterator end() {
		return iterator(m_size, *this);
	}
};


// 1. implement the actual iterator class of the ring class outside
// the ring class's bracket scope to avoid confusion (class nested
// inside another class might become less readable)
// 2. nested template classes, the typename T here is from the ring class,
// in other words, the iterator now has the type T
template<typename T>
class ring<T>::iterator {
private:
	int m_pos;
	ring &m_ring;

public:
	iterator(int pos, ring &aring): m_pos(pos), m_ring(aring) {

	}

	// we need to pass in an useless parameter to
	// indicate that this is overloading the postfix increment
	iterator &operator++(int a) {
		m_pos++;
		return *this;
	}

	iterator &operator++() {
		m_pos++;
		return *this;
	}

	T &operator*() {
		return m_ring.get(m_pos);
	}

	bool operator!=(const iterator& other) const {
		return m_pos != other.m_pos;
	}
};

#endif /* RING_H_ */

//Joshua Christopherson Final
#include <iostream>
#include "EloInput.h"
using namespace std;

EloInput::EloInput(string d, int r) {
	date = d;
	rating = r;
}

string EloInput::getDate() {
	return date;
}

int EloInput::getRating() {
	return rating;
}

void EloInput::display() {
	cout << "Date: " << date << " ||Rating: " << rating << endl;
}
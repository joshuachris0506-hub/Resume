//Joshua Christopherson FINAL
#ifndef ELOINPUT_H
#define ELOINPUT_H
#include <string>
using namespace std;

// This is one entry for my ELO Rating
class EloInput {
private: 
	string date;
	int rating;


public: 
	EloInput(string d = "", int r = 0);

	string getDate();
	int getRating();

	void display();
};


#endif



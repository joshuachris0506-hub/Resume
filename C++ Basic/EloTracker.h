//Joshua Christopherson Final
#ifndef ELOTRACKER_H
#define ELOTRACKER_H
#include "EloInput.h"

//This is for saving data


//This manages multiple Elo inputs

class Elotracker {
private: 
	EloInput entries[20];
	int count;

public:
	Elotracker();

	void addEntry(EloInput e);
	void showHistory();
	void showStatistics();
	void loadData();
};



#endif
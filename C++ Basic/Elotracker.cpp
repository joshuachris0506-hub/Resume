//Joshua Christopherson FINAL (Its currently 12:48 AM while I am working on this.... )

#include <iostream>
#include <fstream>
#include "EloTracker.h"
using namespace std;

Elotracker::Elotracker() {
	count = 0;
}

// Add a new rating entry
void Elotracker::addEntry(EloInput e) {
	if (count < 20) {
		entries[count] = e;
		count++;

		//This will ensure that whatever you input will save!!!!
		ofstream file("elo_data.txt", ios::app);

		file << e.getDate() << "," << e.getRating() << endl;

		file.close();
	}
}

//This will load the data from previous entries!!!
void Elotracker::loadData() {
	ifstream file("elo_data.txt");

	string date;
	int rating;

	while (getline(file, date, ',')) {
		file >> rating;
		file.ignore(); //skips to a new line

		if (count < 20 ) {
			entries[count] = EloInput(date, rating);
			count++;
		}
	}
	file.close();
}

// Display all the entries
void Elotracker::showHistory() {
	cout << "\n--- My ELO History ---\n";
	for (int i = 0; i < count; i++) {
		entries[i].display();
	}
}


//Show the highest and the lowest rating
void Elotracker::showStatistics() {
	if (count == 0) return;

	int highest = entries[0].getRating();
	int lowest = entries[0].getRating();

	for (int i = 1; i < count; i++) {
		int r = entries[i].getRating();
		if (r > highest) highest = r;
		if (r < lowest) lowest = r;
	}
	cout << "\n---Statistics---\n";
	cout << "Highest Rating: " << highest << endl;
	cout << "Lowest Rating: " << lowest << endl;
}


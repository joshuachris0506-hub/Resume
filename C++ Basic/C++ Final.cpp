// C++ Final.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
// Joshua Christopherson FINAL
#include <iostream>
#include "EloInput.h"
#include "EloTracker.h"
using namespace std;

void showIntro() {
    cout << "--------------------------\n";
    cout << "     CHESS ELO TRACKER    \n";
    cout << "--------------------------\n";
    cout << "This tracker allows you to track your chess progress!";
    cout << "You can enter your current rating and view your progress over time!";
}

int main(){
    Elotracker tracker;

    tracker.loadData();

    int choice;

    showIntro();

    // This is where you can pick what option you want inside the ELO tracker!
    do {
        cout << "\nMenu:\n";
        cout << "1.Add Elo Entry\n";
        cout << "2.Show History\n";
        cout << "3.Show Statistics\n";
        cout << "4.Exit\n";
        cout << "Choose: ";
        cin >> choice;

        if (choice == 1) {
            string date;
            int rating;

            cout << "Enter date (EX: 4/28/2026): ";
            cin >> date;

            cout << "Enter Elo Rating (EX: 1786): ";
            cin >> rating;

            EloInput entry(date, rating);
            tracker.addEntry(entry);
        } 
        else if (choice == 2) {
            tracker.showHistory();
        }
        else if (choice == 3) {
            tracker.showStatistics();
        }
        else if (choice == 4) {
            cout << "See you later!\n";
        }
    } while (choice != 4);
    return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file

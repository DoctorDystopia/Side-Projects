/***************************************
*	Program Name: sorryGame.cpp
*	Author: Nicholas Hobar
*	Last Update: 5/12/2017
*	Purpose: Play the game of Sorry with 2-4 Players
***************************************/

#include<iostream> // input/output
#include<iomanip> // input/output manipulation (for game board)
#include<cstdlib> // random number generation
#include<time.h> // access computer's internal time
#include<cctype> // isalpha function
using namespace std;

struct PlayerInfo {
	int position; // Position on board
	int number; // Player 1, player 2, etc.
	int roll; // Current roll
};

// Initialize board and players inside of a function or main?
int RollDice();
int GetSize();
void InitBoard(int[]);
bool Game(PlayerInfo[], int, int[]);
void SwapFirst(PlayerInfo[], int, int[], int);
void SwapLast(PlayerInfo[], int, int[], int);
void DisplayBoard(int[]);

int main() {
	int size = GetSize();
	
	int board[50];
	PlayerInfo player[size];
	InitBoard(board);
	
	// Initializing player array
	for (int i = 0; i < size; i++) {
		player[i].number = i+1;
		player[i].position = 0;
		player[i].roll = 0;
	}
	
	do {
		DisplayBoard(board);
	} while (!Game(player, size, board));
		
	cout << "The winner of the game is Player " << board[49] << endl;
	
	DisplayBoard(board);
	return 0;
}

/*********************************************************
* Name of function: RollDice
*
* Type: int
*
* Parameter(s): None
*
* Purpose: Rolls the dice for the player (generates random int between 1 and 6)
*********************************************************/

int RollDice() {
	int roll; // Dice roll outcome
	int min = 1; // Minimum value for dice roll
	int max =  6; // Maximum value for dice roll
	
	srand(time(NULL)); // Using current time to seed RNG
	roll = rand() % (max - min + 1) + min;
	
	return roll;
}

/*********************************************************
* Name of function: GetSize
*
* Type: int
*
* Parameter(s): None
*
* Purpose: Obtain number of players participating in the game
*********************************************************/

int GetSize() {
	int size;
	// Input validation for number of players
	do {
		cout << "Enter the number of players (2-4): ";
		cin >> size;
		
		if (size < 2 || size > 4) {
			cout << "Please enter a valid number of players" << endl;
		}
	} while (size < 2 || size > 4);
	
	return size;
}

void InitBoard(int board[]) {
	for (int i = 0; i < 50; i++) {
		board[i] = 0;
	}
}

/*********************************************************
* Name of function: Game
*
* Type: void
*
* Parameter(s): None
*
* Purpose: Calculates the player's position on the game board after a dice roll
*********************************************************/

bool Game(PlayerInfo player[], int size, int board[]) {
	
	// Initialize rolls
	int roll1 =0;
	int roll2 = 0;
	int roll = 0;
	
	// Move player according to the dice roll
	for (int i = 0; i < size; i++) {
		roll1 = RollDice();
		roll2 = RollDice();
		roll = roll1 + roll2;
		
		if (player[i].position + roll <= 49 || (roll == 4 || roll == 7 || roll == 11 || roll == 12)) {
			switch(roll) {
				case 2:
				case 3: 
				case 5: 
				case 6: 
				case 8: 
				case 9: 
				case 10: player[i].position += roll;
							board[player[i].position - roll] = 0;
							board[player[i].position] = i + 1;
							break;
				case 4: if (player[i].position != 0) {
								player[i].position -= 1;
							};
							board[player[i].position] = i + 1;
							break;
				case 7: SwapFirst(player, size, board, i);
							break;
				case 11: SwapLast(player, size, board, i);
							break;
				case 12: player[i].position = 1;
							board[player[i].position] = i + 1;
							break;
			}
		} else {
			cout << "Off board: " << player[i].number << " at " << player[i].position + roll << endl;
			break;
		}
	}
	
	return board[49] != 0;
}

/*********************************************************
* Name of function: SwapFirst
*
* Type: void
*
* Parameter(s): PlayerInfo[], int size, int board[], int num
*
* Purpose: Swaps the current player with the first players position
*********************************************************/

void SwapFirst(PlayerInfo player[], int size, int board[], int num) {
	bool isFirst = false;
	int first;
	int i = 50;
	
	while (!isFirst || i < 0) {
		if (board[i] != 0) {
			isFirst = true;
			first = board[i];
		} else {
			i--;
		}
	}
	
	if (isFirst) {
		if (player[num].position < i) {
			int temp = player[num].position;
			player[num].position = i;
			board[i] = num + 1;
			player[first - 1].position = temp;
		}
	}
}

/*********************************************************
* Name of function: SwapLast
*
* Type: void
*
* Parameter(s): PlayerInfo[], int size, int board[], int num
*
* Purpose: Swaps the current player with the last players position
*********************************************************/

void SwapLast(PlayerInfo player[], int size, int board[], int num) {
	bool isLast = false;
	int last;
	int i = 0;
	
	while (!isLast || i > 49) {
		if (board[i] != 0) {
			isLast = true;
			last = board[i];
		} else {
			i++;
		}
	}
	
	if (isLast) {
		if (player[num].position > i) {
			int temp = player[num].position;
			player[num].position = i;
			board[i] = num + 1;
			player[last - 1].position = temp;
		}
	}
}

/*********************************************************
* Name of function: DisplayBoard
*
* Type: void
*
* Parameter(s): None
*
* Purpose: Prints the game board to the screen
*********************************************************/

void DisplayBoard(int board[]) {
	// create 2D array for board instead of hard-coding it?
	cout << endl;
	
	for (int i = 0; i <= 50; i++) {
		if (i % 10 != 0) {
			if (board[i-1] == 0) {
				cout << "_ ";
			} else {
				cout << board[i-1] << " ";
			}
		} else {
			if (board[i-1] == 0) {
				cout << "_ " << endl << endl;
			} else {
				cout << board[i-1] << endl << endl;
			}
		}
	}
}
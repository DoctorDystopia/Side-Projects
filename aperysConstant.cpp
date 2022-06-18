// Apery's Constant esitmator

// Generate (many) three positive integers
// Find if each set are coprimes
	// Are coprime if greatest common divisor is 1
// Take ratio of total sets over number of coprime sets
	
#include<iostream>
#include<cstdlib> // random number generation
#include<time.h> // access computer's internal time
#include<cctype>
using namespace std;

int generateRand();
int gcd(int, int);
bool isCoprime(int, int, int);

int main() {
	int coprimeCount = 0;
	int num[] = {};
	
	for (int i = 0; i < 100; i++) {
		for (int k = 0; k < 3; k++) {
			num[k] = generateRand();
		}
		coprimeCount = isCoprime(num[0], num[1], num[2]);
	}
	
	return 0;
}

int generateRand() {
	int num; // Dice roll outcome
	int min = 1; // Minimum value for dice roll
	int max = 1000000; // Maximum value for dice roll
	
	srand(time(NULL)); // Using current time to seed RNG
	num = rand() % (max - min + 1) + min;
	
	cout << "num = " << num << endl;
	
	return num;
}

// Return greatest common divisor
int gcd(int a, int b) {
	
	if(a < b) {
		swap(a,b);
	}

	while(b > 0)
   {
	  int temp = a % b;
	  a = b;
	  b = temp;
   }
   
   return a;
}

// Determines if inputted set are coprimes
bool isCoprime(int num1, int num2, int num3) {
	int temp = gcd(num1, num2);
	int coprime = gcd(temp, num3);
	
	return coprime == 1;
}
// Apery's Constant Estimator
// Nicholas Hobar
// Last Edit: 6/19/22
// Description: Apery's Constant is the sum of 1/2^3 + 1/3^3 + 1/4^3 + ... ~ 1.202
//              This uses a method to estimate it using coprimes (set of numbers where greatest common divisor is 1).
//              1/1.202 = probability that any three positive integers, chosen at random, will be relatively prime.

#include<iostream>
#include<cstdlib> // Random number generator
//#include<time.h> // Seed RNG with time

using namespace std;

void generateCandidates(int*); // Generates potential coprime set

int *cand = (int*) malloc(3 * sizeof(int)); // If defined here, where to deallocate?
const int MAX = 100; // sample size

// check if memory allocated correctly.
// Should I check this here?
if (!cand) {
        cout << "Memory Allocation Failed :(";
        exit(1);
    }

int main() {
    cout << "hello" << endl;

    srand(time(NULL)); // Use current time as RNG seed
    
    generateCandidates(cand); // move to for loop

    cout << "Main Funct cand: " << *cand << endl;
    
    // Calculates ratio from total sample size
    for (int i=0; i < MAX; i++) {
        coprimeCount += isCoprime(cand);
        notCoprimeCount = MAX - coprimeCount;
    }
    
    float aperyConst = coprimeCount / notCoprimeCount; // What variable type to use here?
    cout << "Estimate of Apery's Constant = " << aperyConst; // Value should be ~1.202

    return 0;
}

// Generates potential coprime set (3 numbers)
void generateCandidates(int *tempCandPtr[3]) {

    for (int i=0; i < 3; i++) {
        *tempCandPtr[i] = rand() % MAX + 1;
        cout << "cand[" << i << "]=" << tempCandPtr[i] << endl;
    }

    int num1 = *tempCandPtr[0];
    int num2 = *tempCandPtr[1];
    int num3 = *tempCandPtr[2];

    cout << "num1 num2 num3 " << num1 << " " << num2 << " " << num3 << endl;
    cout << "funct cand: " << tempCandPtr[0] << endl;
}

// Calculates greatest common divisor
// Only called in isCoprime()
__int16	gcd(__int16 a, __int16 b) {
	
	if(a < b) {
		swap(a,b);
	}

	// Probably don't need a while loop here
	while(b > 0)
   	{
	  __int16 temp = a % b;
	  a = b;
	  b = temp;
   	}
   
   return a;
}

// Checks if generated 3 number set is coprime
bool isCoprime(__int16 cand[]) {
    cout << "isCoprime cand: " << cand[0] << " " << cand[1] << " " << cand[2] << endl;
    bool temp = gcd(cand[0],cand[1]);
    bool coprime = gcd(cand[2], temp);

    return coprime;
}

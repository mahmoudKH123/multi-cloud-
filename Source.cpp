#include<iostream>
using namespace std;
const float pi = 3.142;
float computearea(float radius);

float computearea(float radius) {
	float result;
	result = radius * radius*pi;
	return result;
}
int main() {
	float r, a;
	cout << "User, please enter the value of r" << endl;
	cin >> r;
	a = computearea(r);
	cout << "the area is:" << a<<endl;
	system("pause!!!!!!!");
	return 0;
}

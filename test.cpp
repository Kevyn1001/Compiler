
#include<iostream>
#include<string.h>
#include<stdio.h>

#define bool int
#define verdadeiro 1
#define falso 0
#define string char*

using namespace std;

int t7;
int t5;
int t4;
int t3;
int t2;
int t6;
int t1;

int* v1;
int v2;
int v3;
int v4;
int v5;
int v6;
int v7;
int v8;


int main(void)
{
	t1 = 5;
	v1 = ( int* ) malloc( sizeof(int) * t1 );
	v2 = 0; 
	v3 = 0; 
	v4 = 0; 
l1: 	t5 = t1;
	t4 = v6 < t5;
	t4 = !t4;
	if( t4 ) goto l2;
	t2 = 1;
	v2 = (v2 + t2)  ;
	v5 = v2;
	v1 [ v4 ] = v5;
	cout << v1 [ v4 ] << endl;
	l3:
	t7 = 1;
	t5 = t1;
	t4 = v6 < t5;
	v6 = (v6 + t7)  ;
	goto l1;
l2:
	return 0;
}




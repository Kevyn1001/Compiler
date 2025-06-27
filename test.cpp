
#include<iostream>
#include<string.h>
#include<stdio.h>

#define bool int
#define verdadeiro 1
#define falso 0
#define string char*

using namespace std;

int t8;
int t7;
int t5;
int t4;
int t3;
int t2;
int t6;
int t1;

int v1;
int v2;


int main(void)
{
	v1 = 0; 
	t1 = 20;
	v1 = t1;
	v2 = 0; 
	//*switch init*//
	t2 = 10;
	t3 = v1 == t2;
	t3 = !t3;
	if(t3) goto l3;
	t4 = 3;
	v2 = t4;
	goto l1;
	l3:
	t5 = 20;
	t6 = v1 == t5;
	t6 = !t6;
	if(t6) goto l2;
	t7 = 56;
	v2 = t7;
	goto l1;
	l2:
	//*default*//
	t8 = 0;
	v2 = t8;
	l1:
	//*switch end*//
	return 0;
}




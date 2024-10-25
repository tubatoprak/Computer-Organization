#include <iostream>
#include <fstream>

using namespace std;

void sib(int Sequence[],int n) {
    
   	int Table[10];
	int subSequence[10];
	int cur_size = n;
	int maxlength = 0;
	int max;
	int maxindex = 0;

	Table[0] = 1;  
	
	for (int i = 1; i < cur_size; i++)    //it is called loop  in mars 
	{
		for (int j = i; j > -1; j--)  //it is called innerloop  in mars
		{
			max = Sequence[i];   
			if (Sequence[j] < max)  
			{
				if (  maxlength < Table[j])  
				{
					maxlength = Table[j]; 
				}
			}
			if (j == 0)   //it is called otherif  in mars
			{
				Table[i] = maxlength + 1;   
				maxlength = 0;
			}
		}
	}

	
	for (int k = cur_size-1; k >=0 ; k--) //it is called secondprocess in mars
	{
		max = Table[k];  
		if (maxlength == 0)   //it is called loop  in mars
		{
			maxlength = max;
			maxindex = k;
			cur_size = maxlength;
		}
		else
		{
			if (max > maxlength)
			{
				maxlength = max;
				maxindex = k;
				cur_size = maxlength;
			}
		}
		
	}

	cout << "\n\nSize" << maxlength << endl;


	subSequence[Table[maxindex]-1] = Sequence[maxindex];    //
	
	cur_size = 1;

	//find the sequence
	for (int i = maxindex; i >= 0; i--)
	{
		maxlength = Table[i];

		if (maxlength == Table[maxindex] - cur_size) //s6  
		{
			maxlength = i;
			subSequence[Table[maxlength]-1] = Sequence[maxlength];   
			cur_size++;
		}
	}

	cout << "\nThe longest subsequence\n";
	
	//print the subsequence
	for (int j = 0; j < cur_size; j++)
	{
		cout << subSequence[j] << " ";
	}
}
int main()
{

	int Sequence[10]= {3,10,7,9,4,11};
	int n = 6;
	
	sib(Sequence,n);

	cout << endl;

	return 0;
	
}

/* insert libraries defining standard functions */
#include<stdlib.h>
#include<stdio.h>
#include<math.h>
#include<time.h>
#include<iostream>
#include<fstream>
using namespace std;

int main(int argc, char *argv[]){
//need to feed in trajectory #
  
  int traj=atoi(argv[1]);
  int ntully=atoi(argv[2]);
  float temp2;
  int temp1,ex,state;

  char s1[30];
  sprintf(s1,"123_%d",traj);
  ifstream in123;
  in123.open (s1);
  if(!in123){
    cerr << "***ERROR: could not find the file 123 ***" << endl;
    exit(1);
  }

  ifstream inex("exstateTOT");
  if(!inex){
    cerr << "***ERROR: could not find the file exstateTOT ***" << endl;
    exit(1);
  }
  

  for (int i = 0 ; i < 300 ; i++){
     inex >> ex;
     for (int j = 0 ; j < ntully ; j++){
        in123 >> temp1 >> state >> temp2;
        if(state==ex) cout  << 1 << endl;
        else cout << 0 << endl;
  }}


  inex.close();
  in123.close();
  return 0;
}

#1st num is row
#2nd num is column
#both start at 0
import numpy
import sys
import math

CIstart=numpy.loadtxt(sys.argv[1])
CIend=numpy.loadtxt(sys.argv[2])
MOstart=numpy.loadtxt(sys.argv[3])
MOend=numpy.loadtxt(sys.argv[4])
norb=int(numpy.loadtxt(sys.argv[5]))

sumMO=[0]*len(MOstart)
dens=[0]*len(MOstart)

for n in range(len(MOstart)):
    for j in range(len(CIstart)):
        h=int(CIstart[j,2])
        l=int(CIstart[j,3])
        sumMO[n]=math.pow(MOstart[n,l+4],2)-math.pow(MOstart[n,h+4],2)
        for i in range(norb): 
            sumMO[n]+=2*math.pow(MOstart[n,i+5],2)
        dens[n]+=math.pow(CIstart[j,4],2)*sumMO[n]
        
for n in range(len(MOstart)):
    print n, dens[n]
#print sum(dens)
#print sum(sumMO)

for n in range(60):
    sumx+=MOstart[n+64,2]
    sumy+=MOstart[n+64,3]
    sumz+=MOstart[n+64,4]
com[0]=sumx/60
com[1]=sumy/60
com[2]=sumz/60

for n in range(len(MOstart)-60):
    dist[n,0]=MOstart[n,2]-com[0]
    dist[n,1]=MOstart[n,2]-com[1]
    dist[n,2]=MOstart[n,2]-com[2]
    d[n]=sqrt(math.pow(dist[n,0],2)+math.pow(dist[n,1],2)+math.pow(dist[n,2],2))
    print n, d[n]

#1st num is row
#2nd num is column
#both start at 0
import numpy as np
import sys
import math

MOstart=np.loadtxt(sys.argv[1])
#MOend=np.loadtxt(sys.argv[2])
#sumx=sumy=sumz=0.0
dvec=np.zeros((3,len(MOstart)))
d=np.zeros((len(MOstart)))
'''
pbt1=30=21
pbt2=25=17
'''
pbt1=21
pbt2=17
Rbt=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,28]

coms=np.zeros((3))
come=np.zeros((3))
#calculating normals based on carb or bt span (where C60 is centered)
for i in range (3):
    coms[i]=(MOstart[pbt2-1,i+2]+MOstart[pbt1-1,i+2])/2
    #come[i]=(MOend[pbt2-1,i+2]+MOend[pbt1-1,i+2])/2
#print coms

#calculating com of C60 at t(0)
#for n in range(60):
#    sumx+=MOstart[n+64,2]
#    sumy+=MOstart[n+64,3]
#    sumz+=MOstart[n+64,4]
#com[0]=sumx/60
#com[1]=sumy/60
#com[2]=sumz/60

#calculating distance from C60 to every atom at t(0)
for n in range(len(MOstart)):
    for i in range(3):
        dvec[i,n]=MOstart[n,i+2]-coms[i]
    d[n]=-(math.sqrt(math.pow(dvec[0,n],2)+math.pow(dvec[1,n],2)+math.pow(dvec[2,n],2)))
    if n+1 in Rbt:
        d[n]=-d[n]
    print n+1, d[n]
'''
#calculating com of C60 at t(before CT)
sumx=sumy=sumz=0.0
for n in range(60):
    sumx+=MOend[n+64,2]
    sumy+=MOend[n+64,3]
    sumz+=MOend[n+64,4]
com[0]=sumx/60
com[1]=sumy/60
com[2]=sumz/60

#calculating distance from C60 to every atom at t(before CT)
for n in range(len(MOstart)-60):
    dist[n,0]=MOend[n,2]-com[0]
    dist[n,1]=MOend[n,3]-com[1]
    dist[n,2]=MOend[n,4]-com[2]
    d[n]=math.sqrt(math.pow(dist[n,0],2)+math.pow(dist[n,1],2)+math.pow(dist[n,2],2))
    print n, d[n]
'''


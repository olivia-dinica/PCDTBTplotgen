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
pcarb1=61=44
pcarb2=46=33
'''
pcarb1=44
pcarb2=33
Lcarb=[39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64]

coms=np.zeros((3))
#come=np.zeros((3))
#calculating normals based on carb or bt span (where C60 is centered)
for i in range (3):
    coms[i]=(MOstart[pcarb2-1,i+2]+MOstart[pcarb1-1,i+2])/2
    #come[i]=(MOend[pcarb2-1,i+2]-MOend[pcarb1-1,i+2])/2
    
#calculating distance from C60 to every atom at t(0)
for n in range(len(MOstart)):
    for i in range(3):
        dvec[i,n]=MOstart[n,i+2]-coms[i]
    d[n]=math.sqrt(math.pow(dvec[0,n],2)+math.pow(dvec[1,n],2)+math.pow(dvec[2,n],2))
    if n+1 in Lcarb:
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


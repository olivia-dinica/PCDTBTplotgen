#1: step
#2: state # 
#3: excited state energy   
#4: occupied [yes(1)no(0)]     
#5: exciton(0) ct(1) C60ex(5) other(6)  
#6: osc strength  
#1st num is row
#2nd num is column
#both start at 0
import numpy
import sys

nfile=84
sw_EX_CT=[0]*300
accum_EX_CT=[0]*300
sw_CT_EX=[0]*300
accum_CT_EX=[0]*300
sw_CT_CT=[0]*300
accum_CT_CT=[0]*300

for l in range(1,nfile):
    data=numpy.loadtxt("{0}/justoccup_{0}".format(l))
    #for t in range (12):
    for t in range(len(data[:,4])):
        if t>0:
            ty1=data[t-1,4]
            ty2=data[t,4]
            st1=data[t-1,1]
            st2=data[t,1]
            #print st1, st2
            if (ty1 == 0 and ty2 == 1): #switching from EX to CT
                sw_EX_CT[t]+=1
            if (ty1 == 1 and ty2 == 0): #switching from CT to EX
                sw_CT_EX[t]+=1
            if (ty1 == 1 and ty2 == 1 and st1!=st2):
                sw_CT_CT[t]+=1
for t in range(len(data[:,4])):
    accum_EX_CT[t]+=sw_EX_CT[t]+accum_EX_CT[t-1]
    accum_CT_EX[t]+=sw_CT_EX[t]+accum_CT_EX[t-1]
    accum_CT_CT[t]+=sw_CT_CT[t]+accum_CT_CT[t-1]
    print t, accum_EX_CT[t], accum_CT_EX[t], accum_CT_CT[t]
#    print t, sw_EX_CT[t], sw_EXC60_CT[t], sw_other_CT[t]


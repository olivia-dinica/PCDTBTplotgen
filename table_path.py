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

#print sys.argv[1]
data=numpy.loadtxt(sys.argv[1])
if data[0,4] == 0:
    fst="EX" #fst= first state
elif data[0,4] == 1:
    fst="CT"
elif data[0,4] == 5:
    fst="EXC60"
elif data[0,4] == 6:
    fst="other"

if data[len(data)-1,4] == 0:
    est="EX" #est= end state
elif data[len(data)-1,4] == 1:
    est="CT"
elif data[len(data)-1,4] == 5:
    est="EXC60"
elif data[len(data)-1,4] == 6:
    est="other"

sw_ind=-1
for i in range(len(data[:,4])):
    if data[i,4] != data[0,4]:
        sw_ind=i
        break

print data[0,0], data[0,1], fst, data[0,4]

if sw_ind > -1:
    if data[sw_ind,4] == 0:
        swst="EX" #swst=switch state
    elif data[sw_ind,4] == 1:
        swst="CT"
    elif data[sw_ind,4] == 5:
        swst="EXC60"
    elif data[sw_ind,4] == 6:
        swst="other"
    print data[sw_ind,0], data[sw_ind,1], swst, data[sw_ind,4]

else:
    print "no switch"

print data[len(data)-1,0], data[len(data)-1,1], est, data[len(data)-1,4]

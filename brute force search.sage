reset()
def all_shifts(l,m): # returns all the shifts of a list of numbers
    shifts=[]
    for i in range(0,m):
        b= [(i+j)%m for j in l]
        shifts.append(b)
    shifts_set=[frozenset(i) for i in shifts]
    return shifts_set

def check_cyclic_condition_num(M):# use this if the ground set is [1,2,3,..]
    m=len(M.groundset())
    k=M.rank()
    X=Set(list(M.bases()))
    status=True
    #l=range(0,k)
    #l_shifts=Set(all_shifts(l,m))
    #if l_shifts.issubset(X) is False:
    #    status=False
    #    return status
    #X = X.difference(l_shifts)
    while X.cardinality() > 0:
        y= X.an_element() #checking condition that all shifts of all basis elements are in the basis set
        S=Set(all_shifts(list(y),m))
        if S.issubset(X) is False: # if one of the shifts is outside the basis set, break out of the loop, this cannot be the right permutation
            status=False
            break
        X = X.difference(S)
    return status
 
def list_cyclic_matroids(n,k):
     E = Set(range(n))
     S = Set(E.subsets(k))
     T = iter(S.subsets())
     final_list = []
     count = 0
     logcount = 0
     next(T)
     for t in T:
         count = count+1
         print 'Progress',N(log(count,2)/binomial(n,k),6)*100
         if gcd(t.cardinality(),n) == 1:
            continue
         M = BasisMatroid(groundset=E, bases = t)
         if M.is_valid() == False:
            continue
         if check_cyclic_condition_num(M) == True:
            final_list.append(M)
     return final_list
     
def list_cyclic_matroids_coprime(n,k):
     E = Set(range(n))
     S = Set(E.subsets(k))
     T = iter(S.subsets())
     final_list = []
     count = 0
     logcount = 0
     next(T)
     for t in T:
         count = count+1
         print 'Progress',N(log(count,2)/binomial(n,k),6)*100
         if mod(t.cardinality(),n) != 0:
            continue
         M = BasisMatroid(groundset=E, bases = t)
         if M.is_valid() == False:
            continue
         if check_cyclic_condition_num(M) == True:
            final_list.append(M)
     return final_list
     
from sage.matroids.advanced import *
n = 6
k = 3
Cyc_Mats = list_cyclic_matroids(n,k)
f = file('/home/b/kkhath/matroids/output63_gen.txt','w')
f.write('Number of Cyclic matroids = '+str(len(Cyc_Mats))+'\n')
f.write('Sizes of Cyclic matroids = \n')
for i in Cyc_Mats:
    f.write(str(len(i.bases()))+'\n')
f.write('Bases of Cyclic matroids = \n')
for i in Cyc_Mats:
    f.write(str(list(i.bases()))+'\n\n')
f.close()



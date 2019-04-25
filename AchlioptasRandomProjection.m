function projection=achlioptasRandomProjection(A,e,beta)
n=size(A,1);
k=achlioptasreduceddimension(n,e,beta);
d=size(A,2);
R=achlioptasRandomMatrix(d,k);

projection=RandomProjection(A,R);

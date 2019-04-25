function dimension=achlioptasreduceddimension(n,e,beta)
dimension=ceil((4+2*beta)*log(n)./((e.^2/2)-(e.^3/3)));
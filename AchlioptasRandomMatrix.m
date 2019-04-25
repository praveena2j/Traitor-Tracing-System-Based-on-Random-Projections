function R=achlioptasRandomMatrix(d,k)
% key=0.625;
% rand('state',key);
R_temp=rand(d,k);
R=zeros(d,k);
R(find(R_temp>5/6))=sqrt(3);
R(find(R_temp<1/6))=-sqrt(3);


% function R=achlioptasRandomMatrix(d,k)
% % key=0.625;
% % rand('state',key);
% R_temp=rand(d,k);
% R=zeros(d,k);
% R(find(R_temp>1/2))=1;
% R(find(R_temp<1/2))=-1;

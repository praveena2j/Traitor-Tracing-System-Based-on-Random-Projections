clc;
close all;
clear all;
p=10;
chtimg=zeros(256,256);
notr=input('Enter no of traitors');
for i=1:notr
    traitor(i)=input('Enter Traitor');
end
for m=1:p
    str = int2str(m);
    str = strcat('E:\M Tech\Semester 2\Multimedia Security\Mini Project\watermarked images\',str,'.bmp');
    a = imread(str);
    b=size(a); 
    c=size(find(traitor-m));
    sizc=c(2);
        if (notr~=sizc)
           chtimg=chtimg+double(a/notr);
        end    
        b=size(a);
        for i=1:(b(1)*b(2))
            db(i,m)=a(i);
        end
end
A=db';
e=0.1;
beta=3;
n=size(A,1);
k=achlioptasreduceddimension(n,e,beta);
d=size(A,2);
R=achlioptasRandomMatrix(d,k);
r=(1/sqrt(k))*R;
meanvector=mean(db,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Calculating mean centered images
for l=1:p;
    meancenter(1:b(1)*b(2),l)=double(db(1:b(1)*b(2),l))-meanvector(1:b(1)*b(2));
end
mc=meancenter';
projectedImages = [];
for i = 1 : p
    temp = mc(i,:)*r; % projection of centered images into facespace
    projectedImages = [projectedImages; temp]; 
end
n=256;
m = 35; % width of filers
f = 20; % number of filters
sigma = linspace(0.05,10,p);
H = zeros(m,m,p);
for i=1:f
    %H(:,:,i) = compute_gaussian_filter([m m],sigma(i)/n,[n n]);
    H(:,:,i)=fspecial('gaussian',[m,m],sigma(i)/n);
end 
smoothenedimage=imfilter(chtimg,H,'symmetric','conv');
chtimg=smoothenedimage;

H=fspecial('unsharp');
sharpenedimage=imfilter(chtimg,H,'replicate');
chtimg=sharpenedimage;
test=chtimg;
 for i=1:b(1)*b(2)
     testvector(i,1)=test(i);
 end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%Finding the mean centered test  image
 meancenttest=double(testvector)-meanvector;
 mct=meancenttest';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%projecting the test image as span of eigen faces
 projectedTestImage = mct*r; % Test image feature vector
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%Finding the eucledian distance between test image and data base images
 for i=1:p
     euc(i)=(norm(projectedImages(i,:)-projectedTestImage))^2;
 end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Image with the minimum eucledian distance is the recognised image
 [mindis arg_min]=min(euc);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
 arg_min
 mindis
 figure;
 imshow(uint8(test));
 figure;
 stem(euc);
 for l=1:p
     euc1(l)=(norm(double(testvector')-double(A(l,:))))^2 ;
 end
 figure;
 stem(euc1);
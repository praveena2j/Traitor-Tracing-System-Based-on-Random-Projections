clc;
close all;
clear all;
p=10;
chtimgmin=zeros(256,256)+255;
chtimgmax=zeros(256,256);
notr=input('Enter no of traitors');
for i=1:notr
    traitor(i)=input('Enter Traitor');
end
ti=0
for k=1:p
    str = int2str(k);
    str = strcat('E:\M Tech\Semester 4\Project Work\watermarked images\',str,'.bmp');
    a = imread(str);
    b=size(a); 
    c=size(find(traitor-k));
    sizc=c(2);
    if (notr~=sizc)
        chtimgmin=min(chtimgmin,double(a));
        chtimgmax=max(chtimgmax,double(a));
        ti=ti+1
    end
     b=size(a);
    for i=1:(b(1)*b(2))
        db(i,k)=a(i);
    end
end
chtimg=(chtimgmin+chtimgmax)/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 A=db';
%  %e=0.1;
% % beta=0;
  d=size(A,2);
meanvector=mean(db,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Calculating mean centered images
for l=1:p;
    meancenter(1:b(1)*b(2),l)=double(db(1:b(1)*b(2),l))-meanvector(1:b(1)*b(2));
end
mc=meancenter';
test=chtimg;
 for i=1:b(1)*b(2)
     testvector(i,1)=test(i);
 end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%Finding the mean centered test  image
  meancenttest=double(testvector)-meanvector;
  mct=meancenttest';
for t=1:10
k=1500;
  R=achlioptasRandomMatrix(d,k);
  r=(1/sqrt(k))*R;
%%Finding the mean of the images in the data base
%load AveragingAttack r
projectedImages = [];
for i = 1 : p
    temp = mc(i,:)*r; % projection of centered images into facespace
    projectedImages = [projectedImages; temp]; 
 end
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%projecting the test image as span of eigen faces
  projectedTestImage = mct*r; % Test image feature vector
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%Finding the eucledian distance between test image and data base images
  for i=1:p
      euc(i,t)=(norm(projectedImages(i,:)-projectedTestImage))^2;
  end
end
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eu=mean(euc,2);
(eu./max(eu))'
% % %% Image with the minimum eucledian distance is the recognised image
%   [mindis arg_min]=min(euc);
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%
%   arg_min
%   mindis
%  figure;
%  stem(euc);
%  figure;
%  imshow(uint8(test));
%  imwrite(uint8(test),'chtimgminmax.bmp','BMP');
%  nor=euc./max(euc)
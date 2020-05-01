%% Test Image
clc;
clear all;
close all;
% [fname, path]=uigetfile('.png','provide an Image for testing');
% fname=strcat(path, fname);
% im=imread(fname);
% im=im2bw(im);
% imshow(im);
% title('Test Image');
x=videoinput('winvideo',1);
set(x,'FramesPerTrigger',inf)
set(x,'ReturnedColorSpace','rgb');
x.FrameGrabinterval=5;
start(x);
for i=1:1
    im=getsnapshot(x);
    figure(21),
    imshow(im);
    title('Input Image');
    im=imresize(im,1);
    fname=['C:\Users\Vasanth\Desktop\imageclassificationmatlab\sample\image' num2str(i)];
    imwrite(im,fname,'jpg');
    im=im2bw(im);
    figure(1),imshow(im);
    title('Test Image');
    pause(2);
end  
stop(x);
flushdata(x);
%% Find the class the test image belongs
Ftest=FeatureStatistical(im);
%% Compare with the feature of training image in the database
load db.mat
Ftrain=db(:,1:2);
Ctrain=db(:,3);
for (i=1:size(Ftrain,1));
    dist(i,:)=sum(abs(Ftrain(i,:)-Ftest));
end   
m=find(dist==min(dist),1);
det_class=Ctrain(m);
one='mango';
two='orange';
three='apple';

if det_class==1
    msgbox(strcat('Detected fruit=',one));
elseif det_class==2
    msgbox(strcat('Detected fruit=',two));
elseif det_class==3
    msgbox(strcat('Detected fruit=',three));
end


% msgbox(strcat('Detected Class=',num2str(det_class)));






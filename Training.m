
%% Taking an Image
% [fname, path]=uigetfile('.jpg','Open an Image as input for training');
% fname=strcat(path, fname);
% im=imread(fname);
% im=im2bw(im);
% g=histeq(rgb2gray(imread(fname)));
% imshow(im);
% title('Input Image');
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
%     fname=['C:\Users\Vasanth\Desktop\imageclassificationmatlab\sample\image' num2str(i)];
%     imwrite(im,fname,'jpg');
    im=im2bw(im);
    figure(1),imshow(im);
    title('Test Image');
    pause(2);
end  
stop(x);
flushdata(x);


c=input('Enter the Class(Number from 1-12)');
%% Feature Extraction
F=FeatureStatistical(im);
try 
    load db;
    F=[F c];
    db=[db; F];
    save db.mat db 
catch 
    db=[F c]; % 10 12 1
    save db.mat db 
end




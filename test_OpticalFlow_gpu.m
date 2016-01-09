tic
frame1   = imread('E:\CoreView_258\Master Camera\CoreView_258_Master_Camera_00001.bmp');
frame2   = imread('E:\CoreView_258\Master Camera\CoreView_258_Master_Camera_00002.bmp');
frame1  = gpuArray(frame1);
frame2  = gpuArray(frame2);
[fx,fy]=FarnebackOpticalFlow_GPU(frame1,frame2);
mag=sqrt(fx.^2+fy.^2);
ori=atan2(fy,fx);
toc
% frame1   = imread('E:\CoreView_258\Master Camera\CoreView_258_Master_Camera_00001.bmp');
% frame2   = imread('E:\CoreView_258\Master Camera\CoreView_258_Master_Camera_00002.bmp');
% 
% opticFlow = opticalFlowFarneback;
% reset(opticFlow)
% flow = estimateFlow(opticFlow,frame1);
% flow = estimateFlow(opticFlow,frame2);
% fx2=flow.Vx;
% fy2=flow.Vy;
% ori=flow.Orientation;


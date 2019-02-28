function MotionBlur = pic_after(Img)
%进行5种图片模糊
[M,N] = size(Img);
N = N/3;
interval = 36/N;
%%
%线性运动模糊
%fspecial()
%I = rgb2gray(Img);
%imshow(Img);
%H = fspecial('motion',50,45);
h = my_motion(40,0);
MotionBlur1 = imfilter(Img,h,'replicate');
%figure(2);
%imshow(MotionBlur1,[]);
%%
%匀加速运动模糊
v0 = 0;a = 0.1e-3;T = 100;p3 = 0;
h1 = my_motion_accelerated(T,a,v0,p3,interval);
MotionBlur2 = imfilter(Img,h1,'replicate');
%I1 = rgb2gray(MotionBlur2);
%figure(3);
%imshow(I1,[]);
%imshow(MotionBlur2,[]);
%%
%高频振动模糊
A = 0.1;
MotionBlur3 = my_motion_Vibration_bessel(Img,interval,A,M,N);
%I2 = rgb2gray(MotionBlur3);
%figure(4);
%imshow(I2,[]);
%imshow(MotionBlur3,[]);
%%
%低频振动dmin
MotionBlur4 = my_motion_Vibration_low_single_dmin(Img,interval,A,M,N);
%figure(5);
%imshow(MotionBlur4,[]);
%%
%低频振动dmax
MotionBlur5 = my_motion_Vibration_low_single_dmax(Img,interval,A,M,N);
%figure(6);
%imshow(MotionBlur5,[]);
%%
MotionBlur = {MotionBlur1;MotionBlur2;MotionBlur3;MotionBlur4;MotionBlur5};
end
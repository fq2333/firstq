function MotionBlur1 = my_motion_Vibration_bessel(Img1,interval,A,M,N)
%interval = 0.0129;
%A = 1;
%f = -756*interval:interval:756*interval;
%f = 0:interval:1512*interval;
%f = -1400*interval:interval:1399*interval;
f = 0:interval:2799*interval;
%f = 0:30/2799:30;
%f = 0:1/(2799*interval):1/interval;
%f = 0:2799;
x = 2*pi*A*f;
MTF = abs(besselj(0,x));
H = ones(M,N);
for i = 1:M
    H(i,:) = MTF;
end
%IMG = Img1;
%Img1 = Img{1};
IMG = im2double(Img1);
% IMGg = rgb2gray(IMG);
% figure(1);
% imshow(IMGg);
FI = fft2(IMG);
%FI = fftshift(FI);
% figure(2);
% imshow(FI);
%H = ifftshift(H);
I = H.*FI;
%I = H.*real(FI);
MotionBlur1 = abs(ifft2(I));
MotionBlur1=MotionBlur1/max(MotionBlur1(:));
%MotionBlur1 = imadjust(MotionBlur1,[0 1],[0 1],0.85);%图片变亮 暂时这样用
%MotionBlur1 = ifftshift(MotionBlur1);
%MotionBlur1 = uint8(MotionBlur1);
%Ig = rgb2gray(MotionBlur1);
% figure(3);
% imshow(MotionBlur1);
% h = ifft(H);
% h = abs(h);
% %h = ifftshift(abs(h));
% MotionBlur1 = imfilter(Img{1},h,'replicate');
end
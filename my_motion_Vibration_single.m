function MotionBlur1 = my_motion_Vibration_single(Img1)
A = 1;interval = 0.0129;M = 1513;N = 2800;
%A_m = A/interval_Hypotenuse;%Õñ·ù»»ËãÏñÔªÕñ·ù
MTF = zeros(M,N);MTF1 = zeros(M,N);H = zeros(M,N);
%for fx = -1400*interval(2):interval(2):1399*interval(2)
i = 1;
for fx = 0:interval:2799*interval
    for x = -A:0.01:A
        MTF1(1,i) = exp(-1i*2*pi*fx*x)*0.01/sqrt(A^2-(x)^2);
        MTF(1,i) = MTF(1,i) + MTF1(1,i);
    end
    i = i+1;  
end
MTF(1) = MTF(2);
M = MTF(end-(2-1):end);
MTF(end) = M(1);
MTF = abs(MTF./pi);
% figure(1);
% f = 0:interval(1):2799*interval(1);
% plot(f,MTF);
for j = 1:1513
    H(j,:) = MTF(1,:);
end
%H = ifftshift(H);
IMG = im2double(Img1);
%IMG = Img{1};
FI = fft2(IMG);
I = H.*FI;
MotionBlur1 = abs(ifft2(I));
%MotionBlur1 = uint8(MotionBlur1);
%Ig = rgb2gray(MotionBlur1);
% h = ifft(MTF);
% h = real(h);
% h = ifftshift(abs(h));
% MotionBlur1 = imfilter(Img{1},h,'replicate');
end
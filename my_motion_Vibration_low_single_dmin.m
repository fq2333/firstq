function MotionBlur1 = my_motion_Vibration_low_single_dmin(Img1,interval,A,M,N)
%A = 1;interval = 0.0129;M = 1513;N = 2800;
%A_m = A/interval_Hypotenuse;%Õñ·ù»»ËãÏñÔªÕñ·ù
MTF = zeros(M,N);MTF1 = zeros(M,N);H = zeros(M,N);
%for fx = -1400*interval(2):interval(2):1399*interval(2)
i = 1;
T = 100e-3;
w0 = 2*pi/T;
te = 20e-3;
for fx = 0:interval:2799*interval
    for t = (T/2-te/2):0.005:(T/2+te/2)
        MTF1(1,i) = exp(-1i*2*pi*fx*(A*cos(w0*t)))*0.005;
        MTF(1,i) = MTF(1,i) + MTF1(1,i);
    end
    i = i+1;  
end
MTF = abs(-w0*MTF/pi);
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
MotionBlur1=MotionBlur1/max(MotionBlur1(:));
%MotionBlur1 = imadjust(MotionBlur1,[0 1],[0 1],0.9);
end
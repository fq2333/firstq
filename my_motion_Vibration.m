function MotionBlur1 = my_motion_Vibration(Img1)
A = 0.01;p3 = 30;interval =0.0129;M = 1513;N = 2800;
phi = mod(p3,180)/180*pi;
cosphi = cos(phi);
sinphi = sin(phi);
xsign = sign(cosphi);
MTF = zeros(M,N);MTF1 = zeros(M,N);MTF2 = zeros(M,N);
for x = -(A+eps)*cosphi:0.05:(A+eps)*cosphi
    for y = -A*sinphi:0.05:A*sinphi
        j = 1;
        %for fx = -1400*interval(2):interval(2):1399*interval(2)
        for fx = 0:interval:2799*interval
            i = 1;
            %for fy = -756*interval(1):interval(1):756*interval(1)
            for fy = 0:interval:1512*interval
                MTF1(i,j) = exp(-1i*2*pi*(fx*x+fy*y))*0.05*0.05/sqrt(A^2-(x)^2-(y)^2);
                i = i+1;
            end
            j = j+1;
        end
        MTF2 = MTF2 + MTF1;
    end
    MTF = MTF + MTF2;
end
MTF = abs(MTF./pi);
MTF = ifftshift(MTF);
IMG = im2double(Img1);
% figure(1);
% imshow(IMG);
% IMGg = rgb2gray(IMG);
FI = fft2(IMG);
I = FI.*MTF;
MotionBlur1 = real(ifft2(I));
%MotionBlur1 = uint8(MotionBlur1);
Ig = rgb2gray(MotionBlur1);
% h = ifft(MTF);
% h = real(h);
% h = ifftshift(abs(h));
% MotionBlur1 = imfilter(Img{1},h,'replicate');
% figure(3);
% imshow(MotionBlur1,[]);

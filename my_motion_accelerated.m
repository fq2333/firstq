function h = my_motion_accelerated(T,a,v0,p3,interval)
%p3为方向
%v0 = 0;a = 0.1;T = 40;p3 = 30;
in = interval;
L = (v0*T+0.5*a*T^2)/in;
%像元尺寸换算的矩阵大小
%interval_Hypotenuse = sqrt(sum(interval.^2));
%p2 = L/interval_Hypotenuse;
len = max(1,L);
half = (len-1)/2;% rotate half length around center
phi = mod(p3,180)/180*pi;

cosphi = cos(phi);
sinphi = sin(phi);
xsign = sign(cosphi);
linewdt = 1;

% define mesh for the half matrix, eps takes care of the right size
% for 0 & 90 rotation
sx = fix(half*cosphi + linewdt*xsign - len*eps);
sy = fix(half*sinphi + linewdt - len*eps);
[x,y] = meshgrid(0:xsign:sx, 0:sy);

% define shortest distance from a pixel to the rotated line 
dist2line = (y*cosphi-x*sinphi);% distance perpendicular to the line

rad = sqrt(x.^2 + y.^2);
% find points beyond the line's end-point but within the line width
lastpix = find((rad >= half)&(abs(dist2line)<=linewdt));
%distance to the line's end-point parallel to the line 
x2lastpix = half - abs((x(lastpix) + dist2line(lastpix)*sinphi)/cosphi);

dist2line(lastpix) = sqrt(dist2line(lastpix).^2 + x2lastpix.^2);
dist2line = linewdt + eps - abs(dist2line);
dist2line(dist2line<0) = 0;% zero out anything beyond line width

% unfold half-matrix to the full size
h = rot90(dist2line,2);
h(end+(1:end)-1,end+(1:end)-1) = dist2line;
h = h./(sum(h(:)) + eps*len*len);

if cosphi>0
    h = flipud(h);
end
[xm,ym]=size(h);
[xm,ym] = meshgrid(0:ym-1, 0:xm-1);
rad1 = 1./(T*sqrt(v0^2+2*a*sqrt(xm.^2 + ym.^2)));
rad1(h==0)=0;
h = rad1;
h(1) = h(2);
h = h./(sum(h(:)) + eps*len*len);
end
    
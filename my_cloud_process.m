function my_cloud_process(cloud,bestplane,name)
P = [bestplane(1) bestplane(2) -1];
if name == 'head_h'| name =='head_r'
    Q = [0 0 -1];
else
    Q = [0 0 1];
end
theta = acos(dot(P,Q)/norm(P)/norm(Q));
C = [P(2)*Q(3) -P(1)*Q(3) 0];
%C = cross(P,Q);
C = C/norm(C);
x = C(1);y = C(2);z = C(3);
%�õ�����xoy��ƽ��
M = [cos(theta)+(1-cos(theta))*x^2 (1-cos(theta))*x*y-sin(theta)*z (1-cos(theta))*x*z+sin(theta)*y 0;
     (1-cos(theta))*y*x+sin(theta)*z cos(theta)+(1-cos(theta))*y^2  (1-cos(theta))*y*z-sin(theta)*x 0;
     (1-cos(theta))*z*x-sin(theta)*y (1-cos(theta))*z*y+sin(theta)*x  cos(theta)+(1-cos(theta))*z^2 0;
     0 0 0 1]';
tform = affine3d(M);
cloudout = pctransform(cloud,tform);
%��z����ת
switch name
    case('solarr')
        A = [cos(-pi/64) sin(-pi/64) 0 0; ...
            -sin(-pi/64) cos(-pi/64) 0 0; ...
             0 0 1 0; ...
             0 0 0 1];
    case('head_a')
        A = [cos(pi/4.4) sin(pi/4.4) 0 0; ...
             -sin(pi/4.4) cos(pi/4.4) 0 0; ...
             0 0 1 0; ...
             0 0 0 1];
    case('head_b')
        A = [cos(pi+pi/4.4) sin(pi+pi/4.4) 0 0; ...
             -sin(pi+pi/4.4) cos(pi+pi/4.4) 0 0; ...
             0 0 1 0; ...
             0 0 0 1];
    case('head_h')
        A = [cos(pi/15) sin(pi/15) 0 0; ...
             -sin(pi/15) cos(pi/15) 0 0; ...
             0 0 1 0; ...
             0 0 0 1];
    case('head_r')
        A = [cos(pi/2.8) sin(pi/2.8) 0 0; ...
             -sin(pi/2.8) cos(pi/2.8) 0 0; ...
             0 0 1 0; ...
             0 0 0 1];
    otherwise pause
end
tform = affine3d(A);
cloudout = pctransform(cloudout,tform);
if prod(name == 'head_r',2)
    set(gcf,'color','w','Position',[200 100 700 700]);
else
    set(gcf,'color','w','Position',[200 100 1400 700]);
end
figure;
pcshow(cloudout);
F=getframe(gcf); % ��ȡ�����������ݵ�ͼ��
imwrite(F.cdata,strcat('C:\\Users\\76162\\Desktop\\��ҵ���\\data2\\',name,'0.bmp'));
h = figure;
ax = axes('Parent',h);      % ��hΪ���������£��������꣬���Ҹ������Ϊ��ǰ����
hold(ax,'all');             % ���� plot �Ȼ�ͼ�������Ե�ǰ����ΪĿ��������
ax.YAxis.Visible = 'off';   % ����y�᲻�ɼ�
ax.XAxis.Visible = 'off';   % Ĭ������ on �����ɼ�
plot(cloudout.Location(:,1),cloudout.Location(:,2),'.','MarkerSize',5);%axis tight;
if prod(name == 'head_r',2)
    set(gcf,'color','w','Position',[200 100 700 700]);
else
    set(gcf,'color','w','Position',[200 100 1400 700]);
end
F=getframe(gcf); % ��ȡ�����������ݵ�ͼ��
imwrite(F.cdata,strcat('C:\\Users\\76162\\Desktop\\��ҵ���\\data2\\',name,'.bmp'));
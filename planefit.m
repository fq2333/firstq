clc;clear all;close all;

%%%��άƽ�����
%%%�����������
%�ڵ�
mu=[0 0 0];  %��ֵ
S=[2 0 4;0 4 0;4 0 8];  %Э����
data1=mvnrnd(mu,S,300);   %����200����˹�ֲ�����
%���
mu=[2 2 2];
S=[8 1 4;1 8 2;4 2 8];  %Э����
data2=mvnrnd(mu,S,100);     %����100����������
%�ϲ�����
data=[data1',data2'];
iter = 1000; 

%%% �������ݵ�
 figure;plot3(data(1,:),data(2,:),data(3,:),'o');hold on; % ��ʾ���ݵ�
 number = size(data,2); % �ܵ���
 bestParameter1=0; bestParameter2=0; bestParameter3=0; % ���ƥ��Ĳ���
 sigma = 1;
 pretotal=0;     %�������ģ�͵����ݵĸ���

for i=1:iter
 %%% ���ѡ��������
     idx = randperm(number,3); 
     sample = data(:,idx); 

     %%%���ֱ�߷��� z=ax+by+c
     plane = zeros(1,3);
     x = sample(:, 1);
     y = sample(:, 2);
     z = sample(:, 3);

     a = ((z(1)-z(2))*(y(1)-y(3)) - (z(1)-z(3))*(y(1)-y(2)))/((x(1)-x(2))*(y(1)-y(3)) - (x(1)-x(3))*(y(1)-y(2)));
     b = ((z(1) - z(3)) - a * (x(1) - x(3)))/(y(1)-y(3));
     c = z(1) - a * x(1) - b * y(1);
     plane = [a b -1 c];

     mask=abs(plane*[data; ones(1,size(data,2))]);    %��ÿ�����ݵ����ƽ��ľ���
     total=sum(mask<sigma);              %�������ݾ���ƽ��С��һ����ֵ�����ݵĸ���

     if total>pretotal            %�ҵ��������ƽ�������������ƽ��
         pretotal=total;
         bestplane=plane;          %�ҵ���õ����ƽ��
    end  
 end
 %��ʾ���������ϵ�����
mask=abs(bestplane*[data; ones(1,size(data,2))])<sigma;    
hold on;
k = 1;
for i=1:length(mask)
    if mask(i)
        inliers(1,k) = data(1,i);
        inliers(2,k) = data(2,i);
        plot3(data(1,i),data(2,i),data(3,i),'r+');
        k = k+1;
    end
end

 %%% �������ƥ��ƽ��
 bestParameter1 = bestplane(1);
 bestParameter2 = bestplane(2);
 bestParameter3 = bestplane(4);
 xAxis = min(inliers(1,:)):max(inliers(1,:));
 yAxis = min(inliers(2,:)):max(inliers(2,:));
 [x,y] = meshgrid(xAxis, yAxis);
 z = bestParameter1 * x + bestParameter2 * y + bestParameter3;
 surf(x, y, z);
 title(['bestPlane:  z =  ',num2str(bestParameter1),'x + ',num2str(bestParameter2),'y + ',num2str(bestParameter3)]);
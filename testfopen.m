clear;
fp=fopen('C:\Users\76162\Desktop\毕业设计\pic\result\result\111.nvm.cmvs\00\models\test1.txt','r');
[f,count]=fscanf(fp,'%f');
for i=1:count/6
    location(i,:) = [f(1+6*(i-1)),f(2+6*(i-1)),f(3+6*(i-1))];
    normals(i,:) = [f(4+6*(i-1)),f(5+6*(i-1)),f(6+6*(i-1))];
end
%绘制数据点
number = count/6;
plot3(location(:,1),location(:,2),location(:,3),'b.');
hold on
%每个点的法向量
%quiver3(location(:,1),location(:,2),location(:,3),normals(:,1),normals(:,2),normals(:,3),0.5,'r')
%%%三维平面拟合
bestParameter1=0; bestParameter2=0; bestParameter3=0; % 最佳匹配的参数
sigma = 0.01;
pretotal=0;     %符合拟合模型的数据的个数
iter = 2000;%????
data = location';
for i = 1:3000
    idx = randperm(number,3);
    sample = data(:,idx); 
     
    %%%拟合平面方程 z=ax+by+c
    plane = zeros(1,3);
    x = sample(1,:);
    y = sample(2,:);
    z = sample(3,:);
    
    a = ((z(1)-z(2))*(y(1)-y(3)) - (z(1)-z(3))*(y(1)-y(2)))/((x(1)-x(2))*(y(1)-y(3)) - (x(1)-x(3))*(y(1)-y(2)));
    b = ((z(1) - z(3)) - a * (x(1) - x(3)))/(y(1)-y(3));
    c = z(1) - a * x(1) - b * y(1);
    plane = [a b -1 c];

    mask=abs(plane*[data; ones(1,size(data,2))]);    %求每个数据到拟合平面的距离
    total=sum(mask<sigma);              %计算数据距离平面小于一定阈值的数据的个数

    if total>pretotal            %找到符合拟合平面数据最多的拟合平面
        pretotal=total;
        bestplane=plane;          %找到最好的拟合平面
        dis = mask/sqrt(plane(1)^2+plane(2)^2+1);
    end
end
mask=abs(bestplane*[data; ones(1,size(data,2))])<sigma; 
k = 1;
for i=1:length(mask)
    if mask(i)
        inliers(1,k) = data(1,i);
        inliers(2,k) = data(2,i);
        plot3(data(1,i),data(2,i),data(3,i),'r+');
        k = k+1;
    end
end
%%计算每个点到平面的距离
dis_min = min(dis)
dis_max = max(dis)
dis_mean = sum(dis)/number
dis_var = sqrt(sum(dis - dis_mean.*ones(1,number).^2))/number
 %%% 绘制最佳匹配平面
 bestParameter1 = bestplane(1);
 bestParameter2 = bestplane(2);
 bestParameter3 = bestplane(4);
 xAxis = min(inliers(1,:)):0.01:max(inliers(1,:));
 yAxis = min(inliers(2,:)):0.01:max(inliers(2,:));
 [x,y] = meshgrid(xAxis, yAxis);
 z = bestParameter1 * x + bestParameter2 * y + bestParameter3;
 surf(x, y, z);
 title(['bestPlane:  z =  ',num2str(bestParameter1),'x + ',num2str(bestParameter2),'y + ',num2str(bestParameter3)]);
 
 
 
 
 
 
 
 
 
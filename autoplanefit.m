%平面识别
cloud = pcread('D:\bundler2\bundler_sfm\examples\test4\pmvs\models\option-0000.ply');
location = cloud.Location;
[m,n] = size(location);
number = m;
%%%三维平面拟合
bestParameter1=0; bestParameter2=0; bestParameter3=0; % 最佳匹配的参数
sigma = 0.1;
pretotal=0;     %符合拟合模型的数据的个数
iter = 2000;%????
data = location';
data = double(data);
flag = 1;
j = 1;
while(flag == 1)
    Number = [];
    H = [];
    new = 0;
    NUM = [];
    for i = 1:number
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
        %记录平面信息
        H(i).position = [a b c];
        H(i).num = total;
        H(i).cloud = data(:,mask<sigma);
        [; H(i).col] = find(mask<sigma);
        Number(i) = H(i).num;
    end
    %找到点最多的平面
    [new,NUM] = sort(Number,'descend');
    bestParameter1 = H(NUM(1)).position(1);
    bestParameter2 = H(NUM(1)).position(2);
    bestParameter3 = H(NUM(1)).position(3);
    cloudout(j) = {H(NUM(1)).cloud};
    %figure;
    %plot3(cloudout(1,:),cloudout(2,:),cloudout(3,:),'.');
    bestplane(j) = {[bestParameter1 bestParameter2 bestParameter3]};
    data(:,H(NUM(1)).col)=[];
    number = size(data,2);
    j = j+1;
    if(size(data,2) < 1000)
        flag = 0;
    end
end

figure(1);
pcshow(cloud);
for k = 2:size(cloudout,2)+1
    figure(k);
    out = cell2mat(cloudout(k-1));
    plot3(out(1,:),out(2,:),out(3,:),'.');
end
figure(2);
out1 = cell2mat(cloudout(1));
plot3(out1(1,:),out1(2,:),out1(3,:),'.');
xAxis = min(inliers(1,:)):0.01:max(inliers(1,:));
yAxis = min(inliers(2,:)):0.01:max(inliers(2,:));
[x,y] = meshgrid(xAxis, yAxis);
z = bestParameter1 * x + bestParameter2 * y + bestParameter3;
hold on
surf(x, y, z);
shading flat
%接下来把点云分割
cloud = pcread('C:\Users\76162\Desktop\��ҵ���\pic\result\result\111.nvm.cmvs\00\models\option-0000.ply');
pcshow(cloud);
cl = cloud.Location;
[m,n] = size(cl);
x = cl(:,1);y = cl(:,2);z = cl(:,3);
figure;
% hold on
% grid on
% for i =1:m
%     plot3(x(i),y(i),z(i),'.');
% end
plot3(x,y,z,'.');
%%
%%�ҵ������
% k = 5000;
% [indice, dist] = findNearestNeighbors(cloud, cl(1,:), k);
% % figure(2);
% axis([min(x) max(x) min(y) max(y) min(z) max(z)]);
% cl1 = cl(indice,:);
% %plot3(x(1),y(1),z(1),'.');
% hold on
% %plot3(cl1(:,1),cl1(:,2),cl1(:,3),'.');
%%
x = double(x); y=double(y); z= double(z);
%��ȡ��������
alp = 0.05;region = 0.75;
hole = 1; region = 0.75;
shp = alphaShape(x,y,z,alp);
%�������Ƶİ�������
%��ʾ���ư���
plot(shp)
v= volume(shp)
%title(['v= num2str(v)' ,'m3'])?%�����������ʾ
%color = cloud.Color;
%scatter3(cl(:,1),cl(:,2),cl(:,3));
% figure(2);
% scatter3(cn(:,1),cn(:,2),cn(:,3));
%axis([-4.515170097351074 11.639499664306640 -3.565350055694580 7.102749824523926 -18.660499572753906 -3.614789962768555]);
% fp=fopen('D:\code\testpcl\testpcl1\testpcl1\cloud.txt','a');
% for i=1:m
%     fprintf(fp,'%d %d %d \r\n',cl(i,:));%ע�⣺\r\nΪ���У���ϵͳΪwindows������£���
% end
% fclose(fp);
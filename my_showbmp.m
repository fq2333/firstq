function [sum_t2,sum_t,per] = my_showbmp(I,name)
%I = imread('C:\Users\76162\Desktop\毕业设计\data\solar.bmp');
I = rgb2gray(I);
I = (I==255);
imshow(I,'border','tight','initialmagnification','fit');
if prod(name == 'head_r',2)
    set(gcf,'color','w','Position',[200 100 700 700]);
else
    set(gcf,'color','w','Position',[200 100 1400 700]);
end
F=getframe(gcf); % 获取整个窗口内容的图像
%imwrite(F.cdata,'C:\\Users\\76162\\Desktop\\毕业设计\\data\\solar1.bmp')
imwrite(F.cdata,strcat('C:\\Users\\76162\\Desktop\\毕业设计\\data2\\',name,'1.bmp'));
i = I==0;
%head_h2
se = strel('rectangle',[20 20]);
i1 = imclose(i,se);
%head_h2
SE = strel('rectangle',[1000 1000]);
BW = imclose(i,SE);
% %BW = edge(BW,'canny');
figure;
if prod(name == 'head_r',2)
    set(gcf,'color','w','Position',[200 100 700 700]);
else
    set(gcf,'color','w','Position',[200 100 1400 700]);
end
imshow(BW,'border','tight','initialmagnification','fit');
F=getframe(gcf); % 获取整个窗口内容的图像
%imwrite(F.cdata,'C:\\Users\\76162\\Desktop\\毕业设计\\data\\head_h22.bmp')
imwrite(F.cdata,strcat('C:\\Users\\76162\\Desktop\\毕业设计\\data2\\',name,'2.bmp'));
figure;
if prod(name == 'head_r',2)
    set(gcf,'color','w','Position',[200 100 700 700]);
else
    set(gcf,'color','w','Position',[200 100 1400 700]);
end
imshow(i1,'border','tight','initialmagnification','fit');
F=getframe(gcf); % 获取整个窗口内容的图像
%imwrite(F.cdata,'C:\\Users\\76162\\Desktop\\毕业设计\\data\\head_h23.bmp')
imwrite(F.cdata,strcat('C:\\Users\\76162\\Desktop\\毕业设计\\data2\\',name,'3.bmp'));
total = regionprops(BW,'area');
total2 = regionprops(i1,'area');
t = struct2cell(total);
t = cell2mat(t);
t2 = struct2cell(total2);
t2 = cell2mat(t2);
per = sum(t2)/sum(t);
sum_t2 = sum(t2);
sum_t = sum(t);
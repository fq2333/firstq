%批量读取图片
files = dir(fullfile('C:\\Users\\76162\\Desktop\\毕业设计\\pic\\双目2\\test4\\','*.jpg'));
lengthFiles = length(files);
for i = 1:lengthFiles
    Img{i} = imread(strcat('C:\\Users\\76162\\Desktop\\毕业设计\\pic\\双目2\\test4\\',files(i).name));%文件所在路径
%   disp(strcat('C:\\Users\\76162\\Desktop\\毕业设计\\pic\\双目2\\test4\\',files(i).name)); %打印文件路径
%   imshow(Img{i});
end
%线性运动模糊
%fspecial()
imshow(Img{1});
%H = fspecial('motion',50,45);
H = my_motion(50,45);
MotionBlur = imfilter(Img{1},H,'replicate');
figure(2);
imshow(MotionBlur);
%匀加速运动模糊

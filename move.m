%������ȡͼƬ
files = dir(fullfile('C:\\Users\\76162\\Desktop\\��ҵ���\\pic\\˫Ŀ2\\test4\\','*.jpg'));
lengthFiles = length(files);
for i = 1:lengthFiles
    i
    Img{i} = imread(strcat('C:\\Users\\76162\\Desktop\\��ҵ���\\pic\\˫Ŀ2\\test4\\',files(i).name));%�ļ�����·��
%   disp(strcat('C:\\Users\\76162\\Desktop\\��ҵ���\\pic\\˫Ŀ2\\test4\\',files(i).name)); %��ӡ�ļ�·��
%   imshow(Img{i});
    MotionBlur = pic_after(Img{i});
    imwrite(MotionBlur{1},strcat('./pic-after/mymotionM15/',files(i).name),'jpg','Comment','my motion');
    %imwrite(MotionBlur{2},strcat('./pic-after/mymotionaccelerated_a_0.3/',files(i).name),'jpg','Comment','my motion accelerated');
    %imwrite(MotionBlur{3},strcat('./pic-after/mymotionvibrationbessel-A0.4/',files(i).name),'jpg','Comment','my motion vibration bessel');
    %imwrite(MotionBlur{4},strcat('./pic-after/mymotionvibrationhigh-A0.4/',files(i).name),'jpg','Comment','my motion vibration high');
    %imwrite(MotionBlur{5},strcat('./pic-after/mymotionvibrationlow-A0.4/',files(i).name),'jpg','Comment','my motion vibration low');
    clc;
end


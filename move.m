%������ȡͼƬ
files = dir(fullfile('C:\\Users\\76162\\Desktop\\��ҵ���\\pic\\˫Ŀ2\\test4\\','*.jpg'));
lengthFiles = length(files);
for i = 1:lengthFiles
    Img{i} = imread(strcat('C:\\Users\\76162\\Desktop\\��ҵ���\\pic\\˫Ŀ2\\test4\\',files(i).name));%�ļ�����·��
%   disp(strcat('C:\\Users\\76162\\Desktop\\��ҵ���\\pic\\˫Ŀ2\\test4\\',files(i).name)); %��ӡ�ļ�·��
%   imshow(Img{i});
end
%�����˶�ģ��
%fspecial()
imshow(Img{1});
%H = fspecial('motion',50,45);
H = my_motion(50,45);
MotionBlur = imfilter(Img{1},H,'replicate');
figure(2);
imshow(MotionBlur);
%�ȼ����˶�ģ��

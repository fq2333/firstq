files = dir(fullfile('C:\Users\76162\Desktop\��ҵ���\models\','*.ply'));
lengthFiles = length(files);
for i = 1:lengthFiles
    i
    cloud{i} = pcread(strcat('C:\Users\76162\Desktop\��ҵ���\models\',files(i).name));%�ļ�����·��
    name = strsplit(files(i).name,'.');%name�Ǹ�cell��'head'    'ply'
    %%
    %�õ����ƽ�漰����������
    [dis_min,dis_max,dis_mean,dis_var,bestplane{i}] = my_plane_fit(cloud{i},name{1});
    %��dis_min dis_max dis_mean dis_varд��txt��
    fp=fopen('C:\Users\76162\Desktop\��ҵ���\data2\dis2plane.txt','a');
    fprintf(fp,' \r\n%.4f %.4f %.4f %.4f',dis_min,dis_max,dis_mean,dis_var);%ע�⣺\r\nΪ���У���ϵͳΪwindows������£���
    fclose(fp);
    fp=fopen('C:\Users\76162\Desktop\��ҵ���\data2\bestplane.txt','a');
    fprintf(fp,'%s %d %d %d \r\n',files(i).name,bestplane{i}(1),bestplane{i}(2),-1);%ע�⣺\r\nΪ���У���ϵͳΪwindows������£���
    fclose(fp);
    %%
    %��ȡ���Ƶ�ͶӰͼ����ת����A��ʱ��Ҫ�Լ�������
    my_cloud_process(cloud{i},bestplane{i},name{1});
    I{i} = imread(strcat('C:\\Users\\76162\\Desktop\\��ҵ���\\data2\\',name{1},'.bmp'));
    %%
    %����ͶӰ��ֵ�����õ������������� ������Ƭ�������� ��ֵ
    [sum_t2,sum_t,per] = my_showbmp(I{i},name{1});
    %�������������� ������Ƭ�������� ��ֵд��txt
    fp=fopen('C:\Users\76162\Desktop\��ҵ���\data2\percent.txt','a');
    fprintf(fp,' \r\n%d %d %.4f ',sum_t2,sum_t,per);%ע�⣺\r\nΪ���У���ϵͳΪwindows������£���
    fclose(fp);
    %%
    %�����������н�
    if i == lengthFiles
        for j = 1:i-1
            for k = j+1:i
                P1 = [bestplane{j}(1) bestplane{j}(2) -1];
                P2 = [bestplane{k}(1) bestplane{k}(2) -1];
                theta = my_angle_between_faces(P1,P2);
                fp=fopen('C:\Users\76162\Desktop\��ҵ���\data2\theta.txt','a');
                fprintf(fp,'%s %s %.2f \r\n',files(j).name,files(k).name,theta);
                fclose(fp);
            end
        end
    end
end

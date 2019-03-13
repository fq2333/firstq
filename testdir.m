files = dir(fullfile('C:\Users\76162\Desktop\毕业设计\models\','*.ply'));
lengthFiles = length(files);
for i = 1:lengthFiles
    i
    cloud{i} = pcread(strcat('C:\Users\76162\Desktop\毕业设计\models\',files(i).name));%文件所在路径
    name = strsplit(files(i).name,'.');%name是个cell，'head'    'ply'
    %%
    %得到拟合平面及法向量参数
    [dis_min,dis_max,dis_mean,dis_var,bestplane{i}] = my_plane_fit(cloud{i},name{1});
    %把dis_min dis_max dis_mean dis_var写到txt中
    fp=fopen('C:\Users\76162\Desktop\毕业设计\data2\dis2plane.txt','a');
    fprintf(fp,' \r\n%.4f %.4f %.4f %.4f',dis_min,dis_max,dis_mean,dis_var);%注意：\r\n为换行（在系统为windows的情况下）。
    fclose(fp);
    fp=fopen('C:\Users\76162\Desktop\毕业设计\data2\bestplane.txt','a');
    fprintf(fp,'%s %d %d %d \r\n',files(i).name,bestplane{i}(1),bestplane{i}(2),-1);%注意：\r\n为换行（在系统为windows的情况下）。
    fclose(fp);
    %%
    %获取点云的投影图，旋转矩阵A暂时需要自己决定。
    my_cloud_process(cloud{i},bestplane{i},name{1});
    I{i} = imread(strcat('C:\\Users\\76162\\Desktop\\毕业设计\\data2\\',name{1},'.bmp'));
    %%
    %点云投影二值化，得到轮廓内像素数 点云面片内像素数 比值
    [sum_t2,sum_t,per] = my_showbmp(I{i},name{1});
    %将轮廓内像素数 点云面片内像素数 比值写入txt
    fp=fopen('C:\Users\76162\Desktop\毕业设计\data2\percent.txt','a');
    fprintf(fp,' \r\n%d %d %.4f ',sum_t2,sum_t,per);%注意：\r\n为换行（在系统为windows的情况下）。
    fclose(fp);
    %%
    %计算两两面间夹角
    if i == lengthFiles
        for j = 1:i-1
            for k = j+1:i
                P1 = [bestplane{j}(1) bestplane{j}(2) -1];
                P2 = [bestplane{k}(1) bestplane{k}(2) -1];
                theta = my_angle_between_faces(P1,P2);
                fp=fopen('C:\Users\76162\Desktop\毕业设计\data2\theta.txt','a');
                fprintf(fp,'%s %s %.2f \r\n',files(j).name,files(k).name,theta);
                fclose(fp);
            end
        end
    end
end

%% 读取数据
% clc 
% close all
% clear all
path ='C:\Users\Ren\Desktop\变化检测作业';
userpath(path);
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\变化检测作业\first.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\变化检测作业\second_cut.img');

%% 进行数据的重新的分割
%使用image无法分割三个影像，关键问题就是，读取进来的东西是BSQ格式。。。
first_image = reshape(image1,[608,1676,6]);
% second_image = reshape(image3,[608,1676,6]);
second_image = reshape(image3,[608,1676,6]);
figure;imshow(first_image(:,:,1),[]);
figure;imshow(second_image(:,:,1),[]);
%% 假设配准之后，像元严格对应。




%%
% 问题就是reshape之后就变质了，数据变成了uint8
% figure;imshow(first_image(:,:,1),[]);title('第一幅影像图first image');
% figure;imshow(second_image(:,:,1),[]);title('第二幅影像图 进行几何校正之后 second image');
% 然后就是matlab和envi里面的数据是相反的排列方式。。。
% first_image2 = reshape(image1,[1676,608,6]);
% figure;imshow(first_image2(:,:,1),[]);

% image4 =third_image(:,:,1) - first_image(:,:,1);
% 因为matlab中矩阵维度的不一致，所以我们没有一个好的办法实现图像的。。

% 两个方式：一个是用matlab的图像配准工具箱
% 一个是把图像裁剪到相同的大小，因为现在图像的区域是对应的，所以裁剪可行。
%但是我倾向于使用第一种方式也就是图像配准工具箱的方式。
% 但是图像配准工具箱要首先输出图像
%% 输出图像
weight = 50.0;
first_image50 = (uint16(first_image.*50.0));
second_image50  = (uint16(second_image.*50.0));
% imwrite(first_image50(:,:,1),[path,'firstB1','.tiff'],'tiff','WriteMode','overwrite','ColorSpace','icclab','Compression','none','Resolution',144);
%% 全路径输出文件
imwrite(first_image50(:,:,1),[path,'firstB1','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
imwrite(second_image50(:,:,1),[path,'secondB1','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
% imwrite(first_image50(:,:,2),[path,'firstB2','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
% imwrite(second_image50(:,:,2),[path,'secondB2','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
% imwrite(first_image50(:,:,3),[path,'firstB3','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
% imwrite(second_image50(:,:,3),[path,'secondB3','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
% imwrite(first_image50(:,:,4),[path,'firstB4','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
% imwrite(second_image50(:,:,4),[path,'secondB4','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
% imwrite(first_image50(:,:,5),[path,'firstB5','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
% imwrite(second_image50(:,:,5),[path,'secondB5','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
% imwrite(first_image50(:,:,6),[path,'firstB7','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);
% imwrite(second_image50(:,:,6),[path,'secondB7','.tiff'],'tiff','WriteMode','overwrite','Compression','none','Resolution',144);


%% 读取输出的文件
firstB1 =double(imread('firstB1.tif'))./weight;
secondB1=double(imread('secondB1.tif'))./weight;
% firstB2 =double(imread('firstB2.tif'))./weight;
% secondB2=double(imread('secondB2.tif'))./weight;
% firstB3 =double(imread('firstB3.tif'))./weight;
% secondB3=double(imread('secondB3.tif'))./weight;
% firstB4 =double(imread('firstB4.tif'))./weight;
% secondB4=double(imread('secondB4.tif'))./weight;
% firstB5 =double(imread('firstB5.tif'))./weight;
% secondB5=double(imread('secondB5.tif'))./weight;
% firstB7 =double(imread('firstB7.tif'))./weight;
% secondB7=double(imread('secondB7.tif'))./weight;

%% 进行赋值操作
fixed_image1  = firstB1;
% fixed_image2  = firstB2;
% fixed_image3  = firstB3;
% fixed_image4  = firstB4;
% fixed_image5  = firstB5;
% fixed_image7  = firstB7;
moving_image1 = secondB1;
% moving_image2 = secondB2;
% moving_image3 = secondB3;
% moving_image4 = secondB4;
% moving_image5 = secondB5;
% moving_image7 = secondB7;

%% 进行自动配准操作
[secondB1_estimtor_result] = registerImagesMULTIMODAL(moving_image1,fixed_image1);
% [secondB2_estimtor_result] = registerImagesMULTIMODAL(moving_image2,fixed_image2);
% [secondB3_estimtor_result] = registerImagesMULTIMODAL(moving_image3,fixed_image3);
% [secondB4_estimtor_result] = registerImagesMULTIMODAL(moving_image4,fixed_image4);
% [secondB5_estimtor_result] = registerImagesMULTIMODAL(moving_image5,fixed_image5);
% [secondB7_estimtor_result] = registerImagesMULTIMODAL(moving_image7,fixed_image7);
%% 输出图像
secondB1_fixed = secondB1_estimtor_result.RegisteredImage;
% secondB2_fixed = secondB2_estimtor_result.RegisteredImage;
% secondB3_fixed = secondB3_estimtor_result.RegisteredImage;
% secondB4_fixed = secondB4_estimtor_result.RegisteredImage;
% secondB5_fixed = secondB5_estimtor_result.RegisteredImage;
% secondB7_fixed = secondB7_estimtor_result.RegisteredImage;

%% 拼成一个矩阵
second_image(:,:,1) = secondB1_fixed;
% second_image(:,:,2) = secondB2_fixed;
% second_image(:,:,3) = secondB3_fixed;
% second_image(:,:,4) = secondB4_fixed;
% second_image(:,:,5) = secondB5_fixed;
% second_image(:,:,6) = secondB7_fixed;
%% 图像读取进来了，进行变化检测的部分了。



%% 参考文献
% BIL、BIP 和 BSQ 栅格文件
% http://desktop.arcgis.com/zh-cn/arcmap/10.3/manage-data/raster-and-images/bil-bip-and-bsq-raster-files.htm


%% ��ȡ����
% clc 
% close all
% clear all
path ='C:\Users\Ren\Desktop\�仯�����ҵ';
userpath(path);
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\first.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\second_cut.img');

%% �������ݵ����µķָ�
%ʹ��image�޷��ָ�����Ӱ�񣬹ؼ�������ǣ���ȡ�����Ķ�����BSQ��ʽ������
first_image = reshape(image1,[608,1676,6]);
% second_image = reshape(image3,[608,1676,6]);
second_image = reshape(image3,[608,1676,6]);
figure;imshow(first_image(:,:,1),[]);
figure;imshow(second_image(:,:,1),[]);
%% ������׼֮����Ԫ�ϸ��Ӧ��




%%
% �������reshape֮��ͱ����ˣ����ݱ����uint8
% figure;imshow(first_image(:,:,1),[]);title('��һ��Ӱ��ͼfirst image');
% figure;imshow(second_image(:,:,1),[]);title('�ڶ���Ӱ��ͼ ���м���У��֮�� second image');
% Ȼ�����matlab��envi������������෴�����з�ʽ������
% first_image2 = reshape(image1,[1676,608,6]);
% figure;imshow(first_image2(:,:,1),[]);

% image4 =third_image(:,:,1) - first_image(:,:,1);
% ��Ϊmatlab�о���ά�ȵĲ�һ�£���������û��һ���õİ취ʵ��ͼ��ġ���

% ������ʽ��һ������matlab��ͼ����׼������
% һ���ǰ�ͼ��ü�����ͬ�Ĵ�С����Ϊ����ͼ��������Ƕ�Ӧ�ģ����Բü����С�
%������������ʹ�õ�һ�ַ�ʽҲ����ͼ����׼������ķ�ʽ��
% ����ͼ����׼������Ҫ�������ͼ��
%% ���ͼ��
weight = 50.0;
first_image50 = (uint16(first_image.*50.0));
second_image50  = (uint16(second_image.*50.0));
% imwrite(first_image50(:,:,1),[path,'firstB1','.tiff'],'tiff','WriteMode','overwrite','ColorSpace','icclab','Compression','none','Resolution',144);
%% ȫ·������ļ�
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


%% ��ȡ������ļ�
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

%% ���и�ֵ����
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

%% �����Զ���׼����
[secondB1_estimtor_result] = registerImagesMULTIMODAL(moving_image1,fixed_image1);
% [secondB2_estimtor_result] = registerImagesMULTIMODAL(moving_image2,fixed_image2);
% [secondB3_estimtor_result] = registerImagesMULTIMODAL(moving_image3,fixed_image3);
% [secondB4_estimtor_result] = registerImagesMULTIMODAL(moving_image4,fixed_image4);
% [secondB5_estimtor_result] = registerImagesMULTIMODAL(moving_image5,fixed_image5);
% [secondB7_estimtor_result] = registerImagesMULTIMODAL(moving_image7,fixed_image7);
%% ���ͼ��
secondB1_fixed = secondB1_estimtor_result.RegisteredImage;
% secondB2_fixed = secondB2_estimtor_result.RegisteredImage;
% secondB3_fixed = secondB3_estimtor_result.RegisteredImage;
% secondB4_fixed = secondB4_estimtor_result.RegisteredImage;
% secondB5_fixed = secondB5_estimtor_result.RegisteredImage;
% secondB7_fixed = secondB7_estimtor_result.RegisteredImage;

%% ƴ��һ������
second_image(:,:,1) = secondB1_fixed;
% second_image(:,:,2) = secondB2_fixed;
% second_image(:,:,3) = secondB3_fixed;
% second_image(:,:,4) = secondB4_fixed;
% second_image(:,:,5) = secondB5_fixed;
% second_image(:,:,6) = secondB7_fixed;
%% ͼ���ȡ�����ˣ����б仯���Ĳ����ˡ�



%% �ο�����
% BIL��BIP �� BSQ դ���ļ�
% http://desktop.arcgis.com/zh-cn/arcmap/10.3/manage-data/raster-and-images/bil-bip-and-bsq-raster-files.htm


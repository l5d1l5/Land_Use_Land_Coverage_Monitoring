%% ����BI��NDVI��CVAͼ��仯���

close all;
clc
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\first_matched.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\second_cut.img');
image1 = reshape(image1,[608,1676,6]);
image2 = reshape(image3,[608,1676,6]);
%% matlab��һ��Ϊsample��envi��һ��Ϊһ��sample��������Ҫ���о����ת�á�
image_temp = zeros(608,1676);
image_temp2 = zeros(608,1676);
first_image= zeros(1676,608,6);
second_image= zeros(1676,608,6);
for i=1:6
    image_temp = image1(:,:,i);
    image_temp2 =image2(:,:,i);
    first_image(:,:,i) = image_temp';
    second_image(:,:,i) = image_temp2';
end
second_image = second_image(1:1676,1:608,1:6);
firstB1 = first_image(:,:,1);secondB1 = second_image(:,:,1);
changeB1 = firstB1 - secondB1;

firstB2 = first_image(:,:,2);secondB2 = second_image(:,:,2);
changeB2 = firstB2 - secondB2;

firstB3 = first_image(:,:,3);secondB3 = second_image(:,:,3);
changeB3 = firstB3 - secondB3;

firstB4 = first_image(:,:,4);secondB4 = second_image(:,:,4);
changeB4 = firstB4 - secondB4;

firstB5 = first_image(:,:,5);secondB5 = second_image(:,:,5);
changeB5 = firstB5 - secondB5;

firstB7 = first_image(:,:,6);secondB7 = second_image(:,:,6);
changeB7 = firstB7 - secondB7;

%% ����BI
firstNDVI = (firstB4-firstB3)./(firstB4+firstB3);
secondNDVI  = (secondB4- secondB3)./(secondB4+secondB3);
firstBI = ((firstB5+firstB3)-(firstB4+firstB1))./((firstB5-firstB3)+(firstB4+firstB1));
figure;imshow(firstBI,[]);title('����BIָ��ͼ��');
secondBI = ((secondB5+secondB3)-(secondB4+secondB1))./((secondB5-secondB3)+(secondB4+secondB1));
figure;imshow(secondBI,[]);title('����BIָ��ͼ��');

%% 
[x,y,z]= size(first_image);
matrix_length = zeros(x,y);
matrix_angle = zeros(x,y);
for i=1:x
    for j=1:y
        % ������������Ľ����Ҳ���Ƕ�Ӧ���ص�ļ���
        matrix_length(i,j)=sqrt((firstNDVI(i,j)-secondNDVI(i,j)).^2 +(firstBI(i,j)-secondBI(i,j)).^2);
        matrix_angle(i,j)=atan((secondBI(i,j)-firstBI(i,j))./(secondNDVI(i,j)-firstNDVI(i,j)));
    end
end
figure;imshow(matrix_length,[]);
figure;imshow(matrix_angle,[]);
figure;imagesc(matrix_length);
figure;imagesc(matrix_angle);
%%
matrix_length_origin = matrix_length;
matrix_angle_origin = matrix_angle;
%% �������֮ǰ�Ĺ�һ������
maxlength = max(max(matrix_length));
minlength = min(min(matrix_length));
maxangle = max(max(matrix_angle));
minangle = min(min(matrix_angle));
for i=1:x
    for j=1:y
        matrix_length(i,j) = ((matrix_length(i,j)-minlength)/(maxlength-minlength))*200;
        matrix_angle(i,j) = ((matrix_angle(i,j)-minangle)/(maxangle-minangle))*180;
    end
end
%% ��һ�� 
figure;imagesc(matrix_length);title('��һ��֮�������length');
figure;imagesc(matrix_angle);title('��һ��֮�������angle');
figure;histogram(matrix_length);
figure;histogram(matrix_angle);

matrix_length =uint16(matrix_length);
matrix_angle =uint16(matrix_angle);
%% ���ͼ�񣬵���Arcgis����Envi���зּ�����
imwrite(matrix_length,['C:\Users\Ren\Desktop\�仯�����ҵ\CVA_BI_NDVI\','change_vector_length','.tif'],'tiff','WriteMode','overwrite','Resolution',144);
imwrite(matrix_angle,['C:\Users\Ren\Desktop\�仯�����ҵ\CVA_BI_NDVI\','change_vector_angle','.tif'],'tiff','WriteMode','overwrite','Resolution',144);

%% ��ȡ��������ݣ����м���
image1 = imread('C:\Users\Ren\Desktop\�仯�����ҵ\CVA_BI_NDVI\change_vector_length.tif');
image2 = imread('C:\Users\Ren\Desktop\�仯�����ҵ\CVA_BI_NDVI\change_vector_angle.tif');
figure;imshow(matrix_length_origin,[]);title('ԭʼ����1');
figure;imshow(image1,[]);title('�仯������1');
figure;imshow(matrix_angle_origin,[]);title('ԭʼ����2');
figure;imshow(image2,[]);title('�仯������2');

%% ��ǰ����Ҫ�����⣬���������Ľ��û�취��ԭʼ�����������
% ���ǽ��У���һ��֮��Ľ���������ϵ����ƻ���û��ģ������Ҿ��û��ǿ����õġ�




%% �����Լ�Ԥ����
close all;
clear all;
clc
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\first_matched.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\second_cut.img');
image1 = reshape(image1,[608,1676,6]);
image2 = reshape(image3,[608,1676,6]);
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

%% 
[x,y,z]= size(first_image);
transform_first_image = reshape(first_image,[x*y,z]);
transform_second_image = reshape(second_image,[x*y,z]);
%% ��Ӧ���������
matrix_sub= zeros(x*y,z);
matrix_length = zeros(x*y,1);
for i=1:6
    for j=1:x*y
        % ������������Ľ����Ҳ���Ƕ�Ӧ���ص�ļ���
        matrix_sub(j,i)=transform_first_image(j,i)-transform_second_image(j,i);
    end
end
%% ����ŷʽ���룬Ҳ���Ǳ仯�ķ���
for j=1:x*y
    matrix_length(j,1) = sqrt(matrix_sub(j,1).^2+matrix_sub(j,2).^2+matrix_sub(j,3).^2 +matrix_sub(j,4).^2 +matrix_sub(j,5).^2+matrix_sub(j,6).^2);
end
matrix_length = reshape(matrix_length,[x,y]);
figure;imshow(matrix_length,[]);
%% ����仯�ķ��� ��ʹ��if elseif


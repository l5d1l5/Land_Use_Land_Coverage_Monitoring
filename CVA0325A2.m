clc
close all
clear all
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\变化检测作业\first_matched.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\变化检测作业\second_cut.img');
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
A =first_image;
B =second_image;

matrix_length =zeros(1676,608);
for i =1:1676
    for j=1:608
        matrix_length(i,j)=sqrt(((A(i,j,1)-B(i,j,1)).^2)+((A(i,j,2)-B(i,j,2)).^2)+((A(i,j,3)-B(i,j,3)).^2)+((A(i,j,4)-B(i,j,4)).^2)+((A(i,j,5)-B(i,j,5)).^2)+((A(i,j,6)-B(i,j,6)).^2));
    end
end
%% 这里进行了归一化操作，方便输出，如果不进行归一化操作，根本不会输出正常的东西
maxnumber = max(max(matrix_length));
minnumber = min(min(matrix_length));
for i=1:1676
    for j =1:608
        matrix_length_out(i,j) = ((matrix_length(i,j)-minnumber)/(maxnumber-minnumber))*255;
    end
end
figure;imshow(matrix_length_out,[]);
figure;imagesc(matrix_length_out);title('变化强度图像');
figure;imagesc(matrix_length_out,[141,142]);title('阈值142提取结果');
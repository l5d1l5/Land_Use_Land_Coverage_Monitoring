close all;
clc
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\变化检测作业\first_matched.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\变化检测作业\second_cut.img');
image1 = reshape(image1,[608,1676,6]);
image2 = reshape(image3,[608,1676,6]);
%% matlab中一行为sample，envi中一列为一个sample，这样需要进行矩阵的转置。
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
%% 计算第一个矩阵的协方差
[m,n,l] = size(first_image);
pixels =m*n;
first_matrix = zeros(pixels,6);

for i=1:6
    tempimage01A = first_image(:,:,i);
    tempimage01B = zeros(pixels,l);
    first_matrix(:,i) = reshape(tempimage01A,[1019008,1]);
end
[coeff,score,latent,tsquared,explained] = pca(first_matrix);
[PC1,vary1,explained1]=pca(first_matrix);
Y = first_matrix*PC1;
first_image_PCA=zeros(1676,608,6);
for i=1:6
    first_image_PCA(:,:,i) = reshape(Y(:,i),[1676,608,1]);
end
%% 第二个imgae
[m,n,l] = size(second_image);
pixels =m*n;
second_matrix = zeros(pixels,6);
for i=1:6
    tempimage01A = second_image(:,:,i);
    tempimage01B = zeros(pixels,l);
    second_matrix(:,i) = reshape(tempimage01A,[1019008,1]);
end
[coeff2,score2,latent2,tsquared2,explained2] = pca(second_matrix);
[PC2,vary2,explained3]=pca(second_matrix);
Y2 = second_matrix*PC2;
second_image_PCA=zeros(1676,608,6);
for i=1:6
    second_image_PCA(:,:,i) = reshape(Y2(:,i),[1676,608,1]);
end
%% 提取三个主成分
first_image_3ingredient = first_image_PCA(:,:,1:3);
second_image_3ingredient = second_image_PCA(:,:,1:3);
disp('主成分提取完成');
%% 使用CVA计算
[x,y,z]= size(first_image_3ingredient);
transform_first_image = reshape(first_image_3ingredient,[x*y,z]);
transform_second_image = reshape(second_image_3ingredient,[x*y,z]);
%% 计算差
matrix_sub= zeros(x*y,z);
matrix_length = zeros(x*y,1);
for i=1:3
    for j=1:x*y
        % 两个向量相减的结果，也就是对应像素点的减法
        matrix_sub(j,i)=transform_first_image(j,i)-transform_second_image(j,i);
    end
end
%% 计算欧氏距离
for j=1:x*y
    matrix_length(j,1) = sqrt(matrix_sub(j,1).^2+matrix_sub(j,2).^2+matrix_sub(j,3).^2);
end
matrix_length = reshape(matrix_length,[x,y]);
disp('欧式距离计算完成');
% figure;imshow(matrix_length,[]);title('欧式距离');
%% 提取变化角度
% 我使用的是arctan来获取角度变化，使用前两个主分量计算角度变化即可
x_change =zeros(x*y,1);
y_change =zeros(x*y,1);
angle_change = zeros(x*y,1);
%% 
for j=1:x*y
    x_change(j,1) = transform_first_image(j,1)-transform_second_image(j,1);
    y_change(j,1) = transform_first_image(j,2)-transform_second_image(j,2);
    x= x_change(j,1);
    y= y_change(j,1);
    angle_value = double(y./x);
    angle_change(j,1) = atan(angle_value);
    
end
disp('角度计算完成');
%% 对于计算结果，我们用归一化进行显示
min_value =min(min(angle_change));
max_value =max(max(angle_change));

angle_change_classification = ones(x*y,1);
for j=1:1019008
    number = ((angle_change(j,1)-min_value)/(max_value-min_value));
    angle_change_classification(j,1) =number;
end
angle_change_classification = reshape(angle_change_classification,[1676,608]);
figure;imshow(angle_change_classification,[]);title('角度变化图');
figure;histogram(angle_change_classification);
%% 生成彩色图像显示
figure;imagesc(angle_change_classification);
%% 对于角度进行衡量
% a1=var(angle_change(:));
% figure;histogram(angle_change);
%% 对于角度变化进行分类
% angle_change_classification = zeros(x*y,1);
%%
% for j=1:x*y
%     if (angle_change(j,1)>0 && angle_change(j,1)<0.5)
%         angle_change_classification(j,1) = 0.5;
%     elseif (angle_change(j,1)<0 && angle_change(j,1)>-0.5)
%         angle_change_classification(j,1) = 0.75;
%     elseif (angle_change(j,1)<-0.5)
%         angle_change_classification(j,1) =0.25;
%     elseif (angle_change(j,1)>0.5)
%         angle_change_classification(j,1)=1;
%     end
% end
%%
% angle_change_matrix = reshape(angle_change_classification,[x,y]);
% figure;imshow(angle_change,[]);
% figure;imshow(angle_change_classification,[]);



%% 加上阈值之后，对于角度变化进行分裂
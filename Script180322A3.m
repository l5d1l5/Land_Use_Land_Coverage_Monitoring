%% ���ڶ�ʱ�����ݵĻҶȲ�ֵ�����
%% �����˽���PCA֮��Ĳ�ֵͼ��
%% �Լ�û�н���PCA�Ĳ�ֵͼ�� 6������
clear all;
close all;
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

ans = max(max(max(first_image(:,:,1))));
ans = min(min(min(first_image(:,:,1))));
%% ��ȡ��һ��ͼ������ɷ�
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
% figure;imshow(first_image_PCA(:,:,1),[]);title('����ͼ���һ���ɷ�');
% figure;imshow(first_image_PCA(:,:,2),[]);title('����ͼ���һ���ɷ�');
% figure;imshow(first_image_PCA(:,:,3),[]);title('����ͼ���һ���ɷ�');
% figure;imshow(first_image_PCA(:,:,4),[]);title('����ͼ���һ���ɷ�');
% figure;imshow(first_image_PCA(:,:,5),[]);title('����ͼ���һ���ɷ�');
% figure;imshow(first_image_PCA(:,:,6),[]);title('����ͼ���һ���ɷ�');


%% ��ȡ�ڶ���ͼ������ɷ�

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

%% ���е�һ���ɷֵĲ�ֵ����
matrix_sub = first_image_PCA(:,:,1) - second_image_PCA(:,:,1);
figure;histogram(matrix_sub);title('��ȡ��һ���ɷֲ����в��β�ֵ����');

%% ���Ʋ�ֵͼ���һ���Ҷ�ͼ

figure;histogram(matrix_sub,10,'BinMethod','sturges');
title('PCA��һ���ɷֲ�ֵͼ��ĻҶ�ֱ��ͼ');
axis([-255 ,255,0,300000]);
axis on;
grid on;
%% 
%% ��һ�����εĲ�ֵ��������PCA
figure;title('��ֵͼ��ĻҶ�ֱ��ͼ');
matrix_first_sub  = first_image(:,:,1)-second_image(:,:,1);
subplot(2,3,1);histogram(matrix_first_sub,10,'BinMethod','sturges');
title('Band1','FontSize',10);
axis([-255 ,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');
ans = max(max(max(matrix_first_sub)));
ans = min(min(min(matrix_first_sub)));
%% �ڶ�������
matrix_second_sub  = first_image(:,:,2)-second_image(:,:,2);
subplot(2,3,2);histogram(matrix_second_sub,10,'BinMethod','sturges');
title('Band2','FontSize',10);
axis([-255,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');


%% ��3������
matrix_three_sub  = first_image(:,:,3)-second_image(:,:,3);
subplot(2,3,3);histogram(matrix_three_sub,10,'BinMethod','sturges');
title('Band3','FontSize',10);
axis([-255 ,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');

%% ��4������
matrix_four_sub  = first_image(:,:,4)-second_image(:,:,4);
subplot(2,3,4);histogram(matrix_four_sub,10,'BinMethod','sturges');
title('Band4','FontSize',10);
axis([-255,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');

%% ��5������
matrix_five_sub  = first_image(:,:,5)-second_image(:,:,5);
subplot(2,3,5);histogram(matrix_five_sub,10,'BinMethod','sturges');
title('Band5','FontSize',10);
axis([-255,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');

%% ��6������
matrix_six_sub  = first_image(:,:,6)-second_image(:,:,6);
subplot(2,3,6);histogram(matrix_six_sub,10,'BinMethod','sturges');
title('Band7','FontSize',10);
axis([-255,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');
%% ����ƽ��֮ǰ������

A1 =max(max(matrix_first_sub));
A2 =max(max(matrix_second_sub));
A3 =max(max(matrix_three_sub));
A4 =max(max(matrix_four_sub));
A5 =max(max(matrix_five_sub));
A6 =max(max(matrix_six_sub));
B1 =min(min(matrix_first_sub));
B2 =min(min(matrix_second_sub));
B3 =min(min(matrix_three_sub));
B4 =min(min(matrix_four_sub));
B5 =min(min(matrix_five_sub));
B6 =min(min(matrix_six_sub));
C1 = mean(mean(matrix_first_sub(1:1676,1:608)));
C2 = mean(mean((matrix_second_sub(1:1676,1:608))));
C3 = mean(mean((matrix_three_sub(1:1676,1:608))));
C4 = mean(mean((matrix_four_sub(1:1676,1:608))));
C5 = mean(mean((matrix_five_sub(1:1676,1:608))));
C6 = mean(mean((matrix_six_sub(1:1676,1:608))));
D1 = std2(matrix_first_sub);
D2 = std2(matrix_second_sub);
D3 = std2(matrix_three_sub);
D4 = std2(matrix_four_sub);
D5 = std2(matrix_five_sub);
D6 = std2(matrix_six_sub);


%% 


%% ƽ�ƻҶ�ֱ��ͼ
%% ��һ�����εĲ�ֵ��ƽ��
figure;
matrix_first_sub  = first_image(:,:,1)-second_image(:,:,1)+125;
subplot(2,3,1);histogram(matrix_first_sub,10,'BinMethod','sturges');
title('Band1','FontSize',10);
axis([0,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');
%% �ڶ�������
matrix_second_sub  = first_image(:,:,2)-second_image(:,:,2)+125;
subplot(2,3,2);histogram(matrix_second_sub,10,'BinMethod','sturges');
title('Band2','FontSize',10);
axis([0,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');


%% ��3������
matrix_three_sub  = first_image(:,:,3)-second_image(:,:,3)+125;
subplot(2,3,3);histogram(matrix_three_sub,10,'BinMethod','sturges');
title('Band3','FontSize',10);
axis([0 ,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');

%% ��4������
matrix_four_sub  = first_image(:,:,4)-second_image(:,:,4)+125;
subplot(2,3,4);histogram(matrix_four_sub,10,'BinMethod','sturges');
title('Band4','FontSize',10);
axis([0 ,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');

%% ��5������
matrix_five_sub  = first_image(:,:,5)-second_image(:,:,5)+125;
subplot(2,3,5);histogram(matrix_five_sub,10,'BinMethod','sturges');
title('Band5','FontSize',10);
axis([0,255,0,600000]);axis on;grid on;
% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');

%% ��6������
matrix_six_sub  = first_image(:,:,6)-second_image(:,:,6)+125;
subplot(2,3,6);histogram(matrix_six_sub,10,'BinMethod','sturges');
title('Band7','FontSize',10);
axis([ 0,255,0,600000]);axis on;grid on;

% xlabel('�ҶȲ�ֵ');ylabel('��Ԫ����');
%% ƽ�ƺ��ͼ��
figure;imshow(matrix_first_sub,[]);title('ֱ��ͼƽ��֮��Ĳ�ֵͼ�� BAND1','FontSize',14);
figure;imshow(matrix_second_sub,[]);title('ֱ��ͼƽ��֮��Ĳ�ֵͼ�� BAND2','FontSize',14);
figure;imshow(matrix_three_sub,[]);title('ֱ��ͼƽ��֮��Ĳ�ֵͼ�� BAND3','FontSize',14);
figure;imshow(matrix_four_sub,[]);title('ֱ��ͼƽ��֮��Ĳ�ֵͼ�� BAND4','FontSize',14);
figure;imshow(matrix_five_sub,[]);title('ֱ��ͼƽ��֮��Ĳ�ֵͼ�� BAND5','FontSize',14);
figure;imshow(matrix_six_sub,[]);title('ֱ��ͼƽ��֮��Ĳ�ֵͼ�� BAND6','FontSize',14);
%% �����ֵ�ͷ���
A1 =max(max(matrix_first_sub));
A2 =max(max(matrix_second_sub));
A3 =max(max(matrix_three_sub));
A4 =max(max(matrix_four_sub));
A5 =max(max(matrix_five_sub));
A6 =max(max(matrix_six_sub));
B1 =min(min(matrix_first_sub));
B2 =min(min(matrix_second_sub));
B3 =min(min(matrix_three_sub));
B4 =min(min(matrix_four_sub));
B5 =min(min(matrix_five_sub));
B6 =min(min(matrix_six_sub));
C1 = mean(mean(matrix_first_sub(1:1676,1:608)));
C2 = mean(mean((matrix_second_sub(1:1676,1:608))));
C3 = mean(mean((matrix_three_sub(1:1676,1:608))));
C4 = mean(mean((matrix_four_sub(1:1676,1:608))));
C5 = mean(mean((matrix_five_sub(1:1676,1:608))));
C6 = mean(mean((matrix_six_sub(1:1676,1:608))));
D1 = std2(matrix_first_sub);
D2 = std2(matrix_second_sub);
D3 = std2(matrix_three_sub);
D4 = std2(matrix_four_sub);
D5 = std2(matrix_five_sub);
D6 = std2(matrix_six_sub);


















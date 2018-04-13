
% ��������ͼ���Զ��������ɷֱ任��
% ����ʱ��:2018��3��21��
% ��������:�δ��� 201511190114 ����ѧ�� ����

%% ע������
% ���д��룬����ĳ���·��
%%
close all;
clear all;
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

%% ƴ�����ɷֵľ���
[m,n,l] = size(first_image);
pixels =m*n;
first_matrix = zeros(pixels,6);

for i=1:6
    tempimage01A = first_image(:,:,i);
    tempimage01B = zeros(pixels,l);
    first_matrix(:,i) = reshape(tempimage01A,[1019008,1]);
end
%% ��������Э����
[coeff,score,latent,tsquared,explained] = pca(first_matrix);
% Each column of score corresponds to one principal component. The vector, latent, stores the variances of the four principal components.
% explained ���ǹ����ʺ��ۼƹ�����
% latent�洢��������ֵ

%% ʹ������һ��������PCA����
[PC,vary1,explained1]=pca(first_matrix);
Y = first_matrix*PC;
first_image_PCA=zeros(1676,608,6);
for i=1:6
    first_image_PCA(:,:,i) = reshape(Y(:,i),[1676,608,1]);
end
%% ���ɷ�ͼ���ԭʼͼ��
% figure;imshow(first_image_PCA(:,:,1),[]);title('��һ���ɷ�');
% figure;imshow(first_image_PCA(:,:,2),[]);title('�ڶ����ɷ�');
% figure;imshow(first_image_PCA(:,:,3),[]);title('�������ɷ�');
% figure;imshow(first_image_PCA(:,:,4),[]);title('�������ɷ�');
% figure;imshow(first_image_PCA(:,:,5),[]);title('�������ɷ�');
% figure;imshow(first_image_PCA(:,:,6),[]);title('�������ɷ�');
% image1 = cat(3,first_image_PCA(:,:,1)./255,first_image_PCA(:,:,2)./255,first_image_PCA(:,:,3)./255);
% figure;imshow(image1,[]);title('PCA��ȡ���');

%% ��ȡ�ڶ���Ӱ������ɷ�
[m,n,l] = size(second_image);
pixels =m*n;
second_matrix = zeros(pixels,6);
for i=1:6
    tempimage01A = second_image(:,:,i);
    tempimage01B = zeros(pixels,l);
    second_matrix(:,i) = reshape(tempimage01A,[1019008,1]);
end
[coeff2,score2,latent2,tsquared2,explained2] = pca(second_matrix);
[PC2,vary2,explained2]=pca(second_matrix);
Y2 = second_matrix*PC2;
second_image_PCA=zeros(1676,608,6);
for i=1:6
    second_image_PCA(:,:,i) = reshape(Y2(:,i),[1676,608,1]);
end

%% 
% figure;imshow(second_image_PCA(:,:,1),[]);title('��һ���ɷ�');
% figure;imshow(second_image_PCA(:,:,2),[]);title('�ڶ����ɷ�');
% figure;imshow(second_image_PCA(:,:,3),[]);title('�������ɷ�');
% figure;imshow(second_image_PCA(:,:,4),[]);title('�������ɷ�');
% figure;imshow(second_image_PCA(:,:,5),[]);title('�������ɷ�');
% figure;imshow(second_image_PCA(:,:,6),[]);title('�������ɷ�');
%% ���ɷֺϳ�Ӱ��
image2 = cat(3,first_image_PCA(:,:,1)./255,first_image_PCA(:,:,2)./255,first_image_PCA(:,:,3)./255);
image3 = cat(3,second_image_PCA(:,:,1)./255,second_image_PCA(:,:,2)./255,second_image_PCA(:,:,3)./255);
figure;imshow(image2,[]);title('3');
figure;imshow(image3,[]);title('4');

%% ����������ɷֽ���ң��ͼ��ı仯���
%% ���ɷֲ��취
% ���ڲ�ͬʱ��Ķ�������ݽ������ɷֱ任��֮��ȡ��һ���������ȡ����ֵ��
% ��Ӱ����ʽ��ʾ����Ϊ�仯Ӱ�񡣻Ҷȱ仯�ϴ�ĵط������ֵĸ���������
result_matrix = abs(second_image_PCA(:,:,1)./255-first_image_PCA(:,:,1)./255);
figure;imshow(result_matrix,[]);title('���ɷֲ��취');
mean_PCAfirst = mean2(result_matrix);
%% �ನ�����ɷֱ任��

%% CVA �����ɷ�����һ������

%% ��ֵѡȡ�㷨


%% Ϊɶ���ܾ����Լ������ɷ���ȡ���кܴ�������أ�������






%% һ������������ɷ���ȡ
% [V,S] = eig(coeff);
% [dummy,order] = sort(diag(-S));
% V = V(:,order);%������������������ֵ��С���н������У�ÿһ����һ����������
% S =S(:,order);
% %Y
% Y = zeros(1019008,6);
% Y=first_matrix*V(:,1:6); 
% % *��.*�Ĳ�����ھ������㻹��Ԫ������
% first_image_PCA=zeros(1676,608,6);
% for i=1:6
%     first_image_PCA(:,:,i) = reshape(Y(:,i),[1676,608,1]);
% end
%% ��Ȩ��PCA
%  [wcoeff,~,latent,~,explained] = pca(first_matrix,'VariableWeights','variance');
% Note that the coefficient matrix, wcoeff, is not orthonormal.Calculate the orthonormal coefficient matrix.
% coefforth = inv(diag(std(first_matrix)))* wcoeff;
% Check orthonormality of the new coefficient matrix, coefforth.
% ans = coefforth*coefforth';
% ���Ϊ1����������ȷ�������ġ�

%% 
% �ο�����:
% https://cn.mathworks.com/help/stats/pca.html#bti6n7k-2
% http://blog.sciencenet.cn/blog-1583812-814838.html
% http://blog.csdn.net/ice110956/article/details/20936351
% https://wenku.baidu.com/view/3c2e256c0912a21614792999.html?from=search
% http://lab.must.or.kr/Default.aspx?Page=Principal-component-transform-of-multiband-image&NS=&AspxAutoDetectCookieSupport=1











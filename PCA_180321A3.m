
% 基于输入图像，自动进行主成分变换。
% 创建时间:2018年3月21日
% 代码作者:任春哲 201511190114 地理学部 地信

%% 注意事项
% 运行代码，需更改程序路径
%%
close all;
clear all;
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

%% 拼凑主成分的矩阵
[m,n,l] = size(first_image);
pixels =m*n;
first_matrix = zeros(pixels,6);

for i=1:6
    tempimage01A = first_image(:,:,i);
    tempimage01B = zeros(pixels,l);
    first_matrix(:,i) = reshape(tempimage01A,[1019008,1]);
end
%% 计算矩阵的协方差
[coeff,score,latent,tsquared,explained] = pca(first_matrix);
% Each column of score corresponds to one principal component. The vector, latent, stores the variances of the four principal components.
% explained 就是贡献率和累计贡献率
% latent存储的是特征值

%% 使用另外一个函数的PCA方法
[PC,vary1,explained1]=pca(first_matrix);
Y = first_matrix*PC;
first_image_PCA=zeros(1676,608,6);
for i=1:6
    first_image_PCA(:,:,i) = reshape(Y(:,i),[1676,608,1]);
end
%% 主成分图像和原始图像
% figure;imshow(first_image_PCA(:,:,1),[]);title('第一主成分');
% figure;imshow(first_image_PCA(:,:,2),[]);title('第二主成分');
% figure;imshow(first_image_PCA(:,:,3),[]);title('第三主成分');
% figure;imshow(first_image_PCA(:,:,4),[]);title('第四主成分');
% figure;imshow(first_image_PCA(:,:,5),[]);title('第五主成分');
% figure;imshow(first_image_PCA(:,:,6),[]);title('第六主成分');
% image1 = cat(3,first_image_PCA(:,:,1)./255,first_image_PCA(:,:,2)./255,first_image_PCA(:,:,3)./255);
% figure;imshow(image1,[]);title('PCA提取结果');

%% 提取第二幅影像的主成分
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
% figure;imshow(second_image_PCA(:,:,1),[]);title('第一主成分');
% figure;imshow(second_image_PCA(:,:,2),[]);title('第二主成分');
% figure;imshow(second_image_PCA(:,:,3),[]);title('第三主成分');
% figure;imshow(second_image_PCA(:,:,4),[]);title('第四主成分');
% figure;imshow(second_image_PCA(:,:,5),[]);title('第五主成分');
% figure;imshow(second_image_PCA(:,:,6),[]);title('第六主成分');
%% 主成分合成影像
image2 = cat(3,first_image_PCA(:,:,1)./255,first_image_PCA(:,:,2)./255,first_image_PCA(:,:,3)./255);
image3 = cat(3,second_image_PCA(:,:,1)./255,second_image_PCA(:,:,2)./255,second_image_PCA(:,:,3)./255);
figure;imshow(image2,[]);title('3');
figure;imshow(image3,[]);title('4');

%% 下面进行主成分进行遥感图像的变化监测
%% 主成分差异法
% 对于不同时相的多光谱数据进行主成分变换，之后取第一主分量相减取绝对值，
% 以影像形式显示，即为变化影像。灰度变化较大的地方，表现的更加明亮。
result_matrix = abs(second_image_PCA(:,:,1)./255-first_image_PCA(:,:,1)./255);
figure;imshow(result_matrix,[]);title('主成分差异法');
mean_PCAfirst = mean2(result_matrix);
%% 多波段主成分变换法

%% CVA 对主成分做进一步分析

%% 阈值选取算法


%% 为啥我总觉得自己的主成分提取的有很大的问题呢？？？？






%% 一种有问题的主成分提取
% [V,S] = eig(coeff);
% [dummy,order] = sort(diag(-S));
% V = V(:,order);%将特征向量按照特征值大小进行降序排列，每一列是一个特征向量
% S =S(:,order);
% %Y
% Y = zeros(1019008,6);
% Y=first_matrix*V(:,1:6); 
% % *和.*的差别在于矩阵运算还是元素运算
% first_image_PCA=zeros(1676,608,6);
% for i=1:6
%     first_image_PCA(:,:,i) = reshape(Y(:,i),[1676,608,1]);
% end
%% 加权的PCA
%  [wcoeff,~,latent,~,explained] = pca(first_matrix,'VariableWeights','variance');
% Note that the coefficient matrix, wcoeff, is not orthonormal.Calculate the orthonormal coefficient matrix.
% coefforth = inv(diag(std(first_matrix)))* wcoeff;
% Check orthonormality of the new coefficient matrix, coefforth.
% ans = coefforth*coefforth';
% 结果为1，这个矩阵的确是正交的。

%% 
% 参考文献:
% https://cn.mathworks.com/help/stats/pca.html#bti6n7k-2
% http://blog.sciencenet.cn/blog-1583812-814838.html
% http://blog.csdn.net/ice110956/article/details/20936351
% https://wenku.baidu.com/view/3c2e256c0912a21614792999.html?from=search
% http://lab.must.or.kr/Default.aspx?Page=Principal-component-transform-of-multiband-image&NS=&AspxAutoDetectCookieSupport=1











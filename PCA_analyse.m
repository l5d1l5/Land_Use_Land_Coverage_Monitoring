close all;
clear;
clc;
%% 读取多光谱的数据
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\变化检测作业\first.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\变化检测作业\second_cut.img');
first_image = reshape(image1,[608,1676,6]);
% 6维度矩阵
second_image = reshape(image3,[608,1676,6]);
% 6维度矩阵 

%% 对于数据做预处理操作,由于数据已经变成了0~255的范围，所以没必要进行深入的转化操作
% 获取矩阵的大小信息
[xsize,ysize,bands] = size(first_image);
pixels = xsize*ysize;

% 使用reshape实现每个向量成为同一行
first_image_PCA = reshape(first_image,[pixels bands]);
% 求相关矩阵
correlation = (first_image_PCA'*first_image_PCA)/pixels;

%% 方法一http://blog.csdn.net/chaolei3/article/details/79433026
% 求特征向量 和 特征值
[vector ,value] = eig(correlation);
% 求主分量
PC = first_image_PCA * vector;
PC =reshape(first_image_PCA,[xsize,ysize,bands]);
PC(:,:,bands)/max(max(PC(:,:,bands)));
% 就是使第一主成分的元素值在0-1之间

%% 方法二：http://blog.csdn.net/matlab_matlab/article/details/59483185
[COEFF,latent,explained]=pcacov(correlation);

%  以上调用的输入参数V是总体或样本的协方差矩阵或相关系数矩阵，
% 对于p维总体，V是pxp的矩阵。输出参数COEFF是p个主成分的系数矩阵，它是pxp的矩阵，它的第i列是第i个主成分的系数向量。
% 输出参数latent是p个主成分的方差构成的向量，即V的p个特征值的大小(从大到小)构成的向量。
% 输出参数explained是p个主成分的贡献率向量，已经转化为百分比。
%% 第二种主成分分析
[COEFF,SCORE,latent,tsquare] = pca(correlation);
% <1>[COEFF，SCORE]=princomp（X）
%  根据样本观测值矩阵X进行主成分分析。输入参数X是n行p列的矩阵，每一行对应一个观测(样品)，每一列对应一个变量。输出参数COEFF是p个主成分析的系数矩阵，他是pxp的矩阵，它的第i列对应第i个主成分的系数向量。输出参数SCORE是n个样品的p个主成分得分矩阵，它是n行p列的矩阵，每一行对应一个观测，每一列对应一个主成分，第i行第j列元素表示第i个样品的第j个主成分得分，SCORE与X是一 一对应的关系，是X在新坐标系中的数据，可以通过X*系数矩阵得到。
% <2>[COEFF,SCORE,latent]=princomp（X）
% 返回样本协方差矩阵的特征值向量latent，它是由p个特征值构成的列向量，其中特征值按降序排列。
% <3>[COEFF,SCORE,latent,tsquare]=princomp（X）
% 返回一个包含n个元素的列向量tsquare，它的第i个元素的第i个观测对应的霍特林T^2统计量，表述了第i个观测与数据集(样本观测矩阵)的中心之间的距离，可用来寻找远离中心的极端数据。
% <4>[......]=princomp（X,‘econ’）
%  通过设置参数‘econ’参数，使得当n<=p时，只返回latent中的前n-1个元素(去掉不必要的0元素)及COEFF和SCORE矩阵中相应的列。

%% 
% 参考文献：
% http://blog.csdn.net/chaolei3/article/details/79433026
% http://blog.csdn.net/matlab_matlab/article/details/59483185

% 首先计算遥感图像的协方差的矩阵，6*6个维度，首先要把一个图像里面的像元按照一个原则变成一个超级大的列向量。
% 求多光谱图像的相关系数




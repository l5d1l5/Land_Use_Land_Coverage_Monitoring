close all;
clear;
clc;
%% ��ȡ����׵�����
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\first.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\second_cut.img');
first_image = reshape(image1,[608,1676,6]);
% 6ά�Ⱦ���
second_image = reshape(image3,[608,1676,6]);
% 6ά�Ⱦ��� 

%% ����������Ԥ�������,���������Ѿ������0~255�ķ�Χ������û��Ҫ���������ת������
% ��ȡ����Ĵ�С��Ϣ
[xsize,ysize,bands] = size(first_image);
pixels = xsize*ysize;

% ʹ��reshapeʵ��ÿ��������Ϊͬһ��
first_image_PCA = reshape(first_image,[pixels bands]);
% ����ؾ���
correlation = (first_image_PCA'*first_image_PCA)/pixels;

%% ����һhttp://blog.csdn.net/chaolei3/article/details/79433026
% ���������� �� ����ֵ
[vector ,value] = eig(correlation);
% ��������
PC = first_image_PCA * vector;
PC =reshape(first_image_PCA,[xsize,ysize,bands]);
PC(:,:,bands)/max(max(PC(:,:,bands)));
% ����ʹ��һ���ɷֵ�Ԫ��ֵ��0-1֮��

%% ��������http://blog.csdn.net/matlab_matlab/article/details/59483185
[COEFF,latent,explained]=pcacov(correlation);

%  ���ϵ��õ��������V�������������Э�����������ϵ������
% ����pά���壬V��pxp�ľ����������COEFF��p�����ɷֵ�ϵ����������pxp�ľ������ĵ�i���ǵ�i�����ɷֵ�ϵ��������
% �������latent��p�����ɷֵķ���ɵ���������V��p������ֵ�Ĵ�С(�Ӵ�С)���ɵ�������
% �������explained��p�����ɷֵĹ������������Ѿ�ת��Ϊ�ٷֱȡ�
%% �ڶ������ɷַ���
[COEFF,SCORE,latent,tsquare] = pca(correlation);
% <1>[COEFF��SCORE]=princomp��X��
%  ���������۲�ֵ����X�������ɷַ������������X��n��p�еľ���ÿһ�ж�Ӧһ���۲�(��Ʒ)��ÿһ�ж�Ӧһ���������������COEFF��p�����ɷ�����ϵ����������pxp�ľ������ĵ�i�ж�Ӧ��i�����ɷֵ�ϵ���������������SCORE��n����Ʒ��p�����ɷֵ÷־�������n��p�еľ���ÿһ�ж�Ӧһ���۲⣬ÿһ�ж�Ӧһ�����ɷ֣���i�е�j��Ԫ�ر�ʾ��i����Ʒ�ĵ�j�����ɷֵ÷֣�SCORE��X��һ һ��Ӧ�Ĺ�ϵ����X��������ϵ�е����ݣ�����ͨ��X*ϵ������õ���
% <2>[COEFF,SCORE,latent]=princomp��X��
% ��������Э������������ֵ����latent��������p������ֵ���ɵ�����������������ֵ���������С�
% <3>[COEFF,SCORE,latent,tsquare]=princomp��X��
% ����һ������n��Ԫ�ص�������tsquare�����ĵ�i��Ԫ�صĵ�i���۲��Ӧ�Ļ�����T^2ͳ�����������˵�i���۲������ݼ�(�����۲����)������֮��ľ��룬������Ѱ��Զ�����ĵļ������ݡ�
% <4>[......]=princomp��X,��econ����
%  ͨ�����ò�����econ��������ʹ�õ�n<=pʱ��ֻ����latent�е�ǰn-1��Ԫ��(ȥ������Ҫ��0Ԫ��)��COEFF��SCORE��������Ӧ���С�

%% 
% �ο����ף�
% http://blog.csdn.net/chaolei3/article/details/79433026
% http://blog.csdn.net/matlab_matlab/article/details/59483185

% ���ȼ���ң��ͼ���Э����ľ���6*6��ά�ȣ�����Ҫ��һ��ͼ���������Ԫ����һ��ԭ����һ�����������������
% ������ͼ������ϵ��




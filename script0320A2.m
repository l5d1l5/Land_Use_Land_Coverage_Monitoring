%% ͼ���ںϷ���
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

%% ������׼֮���ͼ���ϸ��Ӧ����ȡͼ��Ĺ�������
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


%% 
figure;histogram(changeB1);
figure;histogram(changeB2);
figure;histogram(changeB3);
figure;histogram(changeB4);
figure;histogram(changeB5);
figure;histogram(changeB7);

%% ע�����������Ӱ�죬����ͼ���ϣ���ͬ�ĵ��ﲻ��仯��ȫһ��
image1 =  cat(3,firstB2./255,secondB3./255,secondB4./255);
figure;imshow(image1,[]);
%% 
image2 =  cat(3,firstB4./255,secondB3./255,secondB4./255);
figure;imshow(image2,[]);
%% 
image3 = cat(3,firstB3./255,secondB4./255,secondB5./255);
figure;imshow(image3,[]);

%% ������ֵ�Ĵ��������趨һ����ֵ���������ֵ���µ��趨Ϊ0��Ҳ���Ǻ�ɫ���䡣
image4 = cat(3,firstB4./255,secondB4./255,secondB5./255);
figure;imshow(image4,[]);title('R firstB4  , G secondB4  , B secondB5');

%% 455
image5 = cat(3,firstB5./255,firstB4./255,secondB5./255);
figure;imshow(image5,[]);title('R firstB5  , G firstB4  , B secondB5');
%% 445
image6 = cat(3,secondB4./255,firstB4./255,secondB5./255);
figure;imshow(image6,[]);title('R secondB4 , G firstB4  , B secondB5');

%% ����ʹ�ò�ֵ�������о���
matrix1 = secondB4 - firstB4;
figure;histogram(matrix1);
% �趨��ֵ������������Ӱ�졣
for i =1:608
    for j = 1:1676
        if(matrix1(i,j)<20)
            matrix1(i,j)=0;
        end
    end
end
figure;imshow(matrix1,[]);

%% ����NDVI,�����ֶ����зּ�����

NDVIchange = secondNDVI - firstNDVI;
figure;histogram(NDVIchange);
NDVIchangeimage =zeros(1676,608,3);
for i=1:1676
    for j =1:608
        if (NDVIchange(i,j) <=-0.5)
            NDVIchangeimage(i,j,1)= 0;NDVIchangeimage(i,j,2)= 0;NDVIchangeimage(i,j,2)= 0;
        elseif ((NDVIchange(i,j)>-0.5)&&(NDVIchange(i,j)<=-0.2))
            NDVIchangeimage(i,j,1) = 0.25;NDVIchangeimage(i,j,2)= 0.25;NDVIchangeimage(i,j,3)= 0.25;
        elseif ((NDVIchange(i,j)>-0.2)&&(NDVIchange(i,j)<=0))
            NDVIchangeimage(i,j,1) = 0.5;NDVIchangeimage(i,j,2)= 0.5;NDVIchangeimage(i,j,3)= 0.5;
        elseif ((NDVIchange(i,j)>0)&&(NDVIchange(i,j)<=0.3))
            NDVIchangeimage(i,j,1) = 0.75;NDVIchangeimage(i,j,2)= 0.75;NDVIchangeimage(i,j,3)= 0.75;
        else 
            NDVIchangeimage(i,j,1) = 1;NDVIchangeimage(i,j,2)= 1;NDVIchangeimage(i,j,3)= 1;
        end
    end
end
figure;imshow(NDVIchange,[]);title('NDVI��ֵ');
figure;imshow(NDVIchangeimage,[0,255]);title('NDVI��ֵ�ּ�ͼ');
            % ����һ���ּ������������Ҹ�ƫ������Arcgis����Envi���档
%% ��NDVI��Ϊͨ�����ݴ������
imageNDVI = cat(3,firstNDVI,secondNDVI,firstB4);
figure;imshow(imageNDVI,[]);title('R NDVIfirst ��G NDVIsecond ��B first4');

%% NDVIʱ��仯
imageNDVI2 =cat(3,firstNDVI,secondNDVI,secondB5);
figure;imshow(imageNDVI2,[]);title('R NDVIfirst , G NDVIsecond  , B secondB5');
% ��ɫ��ʾNDVI�仯Ϊ��

%% ���ж�ʱ���ͼ���ںϲ���
imageNDVI3 =cat(3,firstNDVI,secondNDVI,firstB5);
figure;imshow(imageNDVI3);








%% 用于生成变化向量，生成基本6个波段构成的变化向量
%% 进行双窗口变步长阈值搜索算法
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
A =first_image;
B =second_image;
%% 变化强度的计算
matrix_length =zeros(1676,608);
for i =1:1676
    for j=1:608
        matrix_length(i,j)=sqrt(((A(i,j,1)-B(i,j,1)).^2)+((A(i,j,2)-B(i,j,2)).^2)+((A(i,j,3)-B(i,j,3)).^2)+((A(i,j,4)-B(i,j,4)).^2)+((A(i,j,5)-B(i,j,5)).^2)+((A(i,j,6)-B(i,j,6)).^2));
    end
end
%% 
% figure;imshow(matrix_length,[]);
% figure;imagesc(matrix_length);
maxnumber = max(max(matrix_length));
minnumber = min(min(matrix_length));
for i=1:1676
    for j =1:608
        matrix_length(i,j) = ((matrix_length(i,j)-minnumber)/(maxnumber-minnumber))*255;
    end
end
maxnumber = max(max(matrix_length));
minnumber = min(min(matrix_length));

imwrite(matrix_length,['C:\Users\Ren\Desktop\变化检测作业\双窗口变步长GIS\','change_vector_length','.tif'],'tiff','WriteMode','overwrite','Resolution',144);

%% 开始准备双窗口变步长阈值提取算法

figure;imagesc(matrix_length,[50 100]);title('变化强度的彩色渲染图像');
% figure;histogram(matrix_length);
%% 我们就是要基于这个变化强度的彩色强度来选取ROI，然后创建buffer。
% figure;histogram(matrix_length,'BinMethod','sturges');
% [xinput,yinput] = ginput(6);
figure;imshow(matrix_length,[]);title("变化强度的图像");
%% 获取多边形的形状 
x=[290,291,292,293,294,295,297,299,300,301,302,301,299,297,295,293,291,290];
y =[692,692,691,691,691,691,691,692,693,694,697,700,700,700,700,699,698,696];
figure;patch('XData',x,'YData',y);
polyin = polyshape(x,y);
figure;plot(polyin);
hold on
threshold =20;
polyout = polybuffer(polyin,threshold);
plot(polyout);
%% 用上面的两个东西提变化强度图像的区域
% [xin,yin] = boundary(polyin);
% [xout,yout] = boundary(polyout);
% for i=1:1967
%     for j =1:608
%         if(myinpolygon(i,j,xin,yin)==1)
%             matrix_in(i,j) = matrix_length(i,j);
%         else 
%             matrix_in(i,j) =0;
%         end
%     end
% end
% figure;imshow(matrix_in);
% figure;histogram(matrix_in);

%% 获取多边形的边界点
[xin,yin] = boundary(polyin);
[xout,yout] = boundary(polyout);
%% 直接，裁剪区域，主要是通过大小判断
max_x_out = uint16(max(xout));
min_x_out =uint16(min(xout));
max_y_out = uint16(max(yout));
min_y_out = uint16(min(yout));

max_x_in = uint16(max(xin));
min_x_in =  uint16(min(xin));
max_y_in = uint16(max(yout));
min_y_in = uint16(min(yin));
%% 根据上面的区域获取一个边界矩形
matrix_outside = matrix_length(min_y_out:max_y_out,min_x_out:max_x_out);
figure;imshow(matrix_outside,[]);
cts =1;
for i=min_y_out:max_y_out
    for j=min_x_out:max_x_out
        array_points(cts,1) = i;
        array_points(cts,2) = j;
        cts=cts+1;
    end
end
%% 获取多边形的点位，并且判断点是不是在多边形里面 （方法之一）（调用inpoly函数）
out_points = uint16(polyout.Vertices);%取整数
result = uint8(inpoly(array_points,out_points));
max(max(result));
%% 判断点是不是在多边形里面（调用内置的inpolygon函数）
% 返回的东西是逻辑数组
x_array = array_points(:,1);
y_array = array_points(:,2);
[in,on] = inpolygon(x_array,y_array,xin,yin);
% 判断点的数目到底是什么情况，为什么返回的都是0.
%% 统计点的数目
number_in = numel(array_points(in));


%% 将结果输出并且进行判断 
[x,y] =size(result);
x_length =max_x_out-min_x_out+1;
y_length =max_y_out-min_y_out+1;
result=reshape(result,[x_length,y_length]);
figure;imshow(result,[]);

%% 
% 2018年3月25日11:01:35
% 目前最大的问题就是多边形的选择，点如果是有规则的，就很难进行判断.
% 似乎是由于点的顺序排列的问题，导致我们判断点是不是在多边形里面非常困难









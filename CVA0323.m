
%% �������ɱ仯���������ɻ���6�����ι��ɵı仯����
%% ����˫���ڱ䲽����ֵ�����㷨
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
A =first_image;
B =second_image;
%% �仯ǿ�ȵļ���
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

imwrite(matrix_length,['C:\Users\Ren\Desktop\�仯�����ҵ\˫���ڱ䲽��GIS\','change_vector_length','.tif'],'tiff','WriteMode','overwrite','Resolution',144);

%% ��ʼ׼��˫���ڱ䲽����ֵ��ȡ�㷨

figure;imagesc(matrix_length,[50 100]);title('�仯ǿ�ȵĲ�ɫ��Ⱦͼ��');
% figure;histogram(matrix_length);
%% ���Ǿ���Ҫ��������仯ǿ�ȵĲ�ɫǿ����ѡȡROI��Ȼ�󴴽�buffer��
% figure;histogram(matrix_length,'BinMethod','sturges');
% [xinput,yinput] = ginput(6);
figure;imshow(matrix_length,[]);title("�仯ǿ�ȵ�ͼ��");
%% ��ȡ����ε���״ 
x=[290,291,292,293,294,295,297,299,300,301,302,301,299,297,295,293,291,290];
y =[692,692,691,691,691,691,691,692,693,694,697,700,700,700,700,699,698,696];
figure;patch('XData',x,'YData',y);
polyin = polyshape(x,y);
figure;plot(polyin);
hold on
threshold =20;
polyout = polybuffer(polyin,threshold);
plot(polyout);
%% �����������������仯ǿ��ͼ�������
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

%% ��ȡ����εı߽��
[xin,yin] = boundary(polyin);
[xout,yout] = boundary(polyout);
%% ֱ�ӣ��ü�������Ҫ��ͨ����С�ж�
max_x_out = uint16(max(xout));
min_x_out =uint16(min(xout));
max_y_out = uint16(max(yout));
min_y_out = uint16(min(yout));

max_x_in = uint16(max(xin));
min_x_in =  uint16(min(xin));
max_y_in = uint16(max(yout));
min_y_in = uint16(min(yin));
%% ��������������ȡһ���߽����
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
%% ��ȡ����εĵ�λ�������жϵ��ǲ����ڶ�������� ������֮һ��������inpoly������
out_points = uint16(polyout.Vertices);%ȡ����
result = uint8(inpoly(array_points,out_points));
max(max(result));
%% �жϵ��ǲ����ڶ�������棨�������õ�inpolygon������
% ���صĶ������߼�����
x_array = array_points(:,1);
y_array = array_points(:,2);
[in,on] = inpolygon(x_array,y_array,xin,yin);
% �жϵ����Ŀ������ʲô�����Ϊʲô���صĶ���0.
%% ͳ�Ƶ����Ŀ
number_in = numel(array_points(in));


%% �����������ҽ����ж� 
[x,y] =size(result);
x_length =max_x_out-min_x_out+1;
y_length =max_y_out-min_y_out+1;
result=reshape(result,[x_length,y_length]);
figure;imshow(result,[]);

%% 
% 2018��3��25��11:01:35
% Ŀǰ����������Ƕ���ε�ѡ�񣬵�������й���ģ��ͺ��ѽ����ж�.
% �ƺ������ڵ��˳�����е����⣬���������жϵ��ǲ����ڶ��������ǳ�����









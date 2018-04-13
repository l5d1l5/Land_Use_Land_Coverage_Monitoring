%% ����CVA0323����������CVA0323�ܲ�˳�����������ڻ���Ҫ�����µ���Ŀ

%% �������룬Ӱ�����Ĳ�������bufferѡȡ�Ĵ�С
%% �Լ�pace������
%% 55 �е�buffer_sizeֵ���о�
%%  buffer 5 ��ֵ 141
%%  buffer 10 ��ֵ 142
%%  buffer 15 ��ֵ 157
%%  buffer 20 ��ֵ 159

clc
close all
clear all
[image1,p1,t1]=freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\first_matched.img');
[image6,p2,t2]=freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\first.img');
[image3,p3,t3] = freadenvinew('C:\Users\Ren\Desktop\�仯�����ҵ\second_cut.img');
image1 = reshape(image1,[608,1676,6]);
image2 = reshape(image3,[608,1676,6]);
image3 = reshape(image6,[608,1676,6]);

for i=1:6
    image_temp = image1(:,:,i);
    image_temp2 =image2(:,:,i);
    image_temp3 =image3(:,:,i);
    first_image(:,:,i) = image_temp';
    second_image(:,:,i) = image_temp2';
    third_image(:,:,i) =image_temp3';
end
A =first_image;
B =second_image;
C =third_image;
%% �鿴����ͼ�񵽵���ÿ��band�ϲ����
% band3 = first_image(:,:,3) -second_image(:,:,3);
% band4 = first_image(:,:,4) -second_image(:,:,4);
% figure;histogram(band3);
% figure;histogram(band4);
% 
% 
% band3A =third_image(:,:,3) -second_image(:,:,3);
% band4A =third_image(:,:,4) -second_image(:,:,4);
% figure;histogram(band3A);
% figure;histogram(band4A);
% 
% figure;histogram(band3A-band3);
% figure;histogram(band4A-band4);

%%
% figure;imshow(A(:,:,1),[]);
% figure;imshow(B(:,:,1),[]);
%%

for i =1:1676
    for j=1:608
        matrix_length(i,j)=sqrt(((A(i,j,1)-B(i,j,1)).^2)+((A(i,j,2)-B(i,j,2)).^2)+((A(i,j,3)-B(i,j,3)).^2)+((A(i,j,4)-B(i,j,4)).^2)+((A(i,j,5)-B(i,j,5)).^2)+((A(i,j,6)-B(i,j,6)).^2));
    end
end
%% 
figure;imshow(matrix_length,[]);
%% ��������˹�һ�������������������������й�һ������������������������Ķ���
maxnumber = max(max(matrix_length));
minnumber = min(min(matrix_length));
for i=1:1676
    for j =1:608
        matrix_length_out(i,j) = ((matrix_length(i,j)-minnumber)/(maxnumber-minnumber))*255;
    end
end
imwrite(matrix_length_out,['C:\Users\Ren\Desktop\�仯�����ҵ\˫���ڱ䲽��GIS\','change_vector_length','.tif'],'tiff','WriteMode','overwrite','Resolution',144);
%%
figure;imagesc(matrix_length,[75 150]);title('�仯ǿ�ȵĲ�ɫ��Ⱦͼ��');
imwrite(matrix_length,['C:\Users\Ren\Desktop\�仯�����ҵ\˫���ڱ䲽��GIS\','change_vector_length_1','.tif'],'tiff','WriteMode','overwrite','Resolution',144);
%% ���ͱ仯ѵ������ѡȡ
% x=[290,291,292,293,294,295,297,299,300,301,302,301,299,297,295,293,291,290];
% y =[692,692,691,691,691,691,691,692,693,694,697,700,700,700,700,699,698,696];
%% ����ѡ���µ�������
x = [301,311,311,301];
y = [1604,1604,1613,1613];

polyin = polyshape(x,y);
buffer_size =5;
polyout = polybuffer(polyin,buffer_size);
%% ���ͱ仯ѵ������ѡȡ
[xin,yin] = boundary(polyin);
[xout,yout] = boundary(polyout);
figure;plot(xin,yin);
hold on ;
plot(xout,yout);
hold off;
%% 
max_x_out = uint16(max(xout));
min_x_out =uint16(min(xout));
max_y_out = uint16(max(yout));
min_y_out = uint16(min(yout));

max_x_in = uint16(max(xin));
min_x_in =  uint16(min(xin));
max_y_in = uint16(max(yin));
min_y_in = uint16(min(yin));
%% �ж������ڲ���������Ǹ���Χ���棬���ͱ仯ѵ������ѡȡ
for yy =1:1676
    for xx = 1:608
        if (inpolygon(yy,xx,yin,xin))
            matrix_result_in(yy,xx) = matrix_length(yy,xx);
        else 
            matrix_result_in(yy,xx) = nan;
        end
    end
end

for yyy =1:1676
    for xxx =1:608
        if(inpolygon(yyy,xxx,yout,xout))
            matrix_result_out(yyy,xxx) = matrix_length(yyy,xxx);
        else
           matrix_result_out(yyy,xxx) = nan;
        end
    end
end

%% ��������Ĳü�
matrix_result_out=matrix_result_out(min_y_out:max_y_out,min_x_out:max_x_out);
matrix_result_in = matrix_result_in(min_y_in:max_y_in,min_x_in:max_x_in);
figure;subplot(1,2,1);imshow(matrix_result_out,[]);title('�ⲿ����,buffer=5');
subplot(1,2,2);imshow(matrix_result_in,[]);title('�ڲ�����');
%% ��ֵ������Χ�������趨
number_set = 10;
Success_rate =10;

%% ͼ��Ҷ�ֵ�仯���ֵ��ͼ��Ҷ�ֵ�仯��Сֵ
max_change_value = max(max(matrix_result_out));
min_change_value = min(min(matrix_result_out));

% ��һ�β���
pace = fix((max_change_value - min_change_value)/number_set);
% �����仯����ֵ���
threshold = uint16((max_change_value-pace):(-1)*pace:min_change_value);
% ������ֵ���б仯���ļ��
result_current_threshold = find_best_threshold(threshold,matrix_result_out,matrix_result_in);
best_threshold = (sortrows(result_current_threshold,7)); %142
% ���ɹ��ʺ���С�ɹ��ʵĲ�
Success_rate = max(result_current_threshold(:,7))-min(result_current_threshold(:,7));
best_threshold = best_threshold(1,8);% ����ǵ�ǰ��������õ���ֵ
%% ѭ����ñ仯����ʵ���ֵ
while (Success_rate >0.05)
    pace = fix((max_change_value - min_change_value)/number_set);
    threshold_next_min =best_threshold -pace;
    threshold_next_max = best_threshold +pace;
% 
    number_set=2*number_set;
    pace = fix((max_change_value - min_change_value)/number_set);
    threshold = uint16(threshold_next_max:(-1)*pace:threshold_next_min);
    result_current_threshold = find_best_threshold(threshold,matrix_result_out,matrix_result_in);
    best_threshold = (sortrows(result_current_threshold,7)); %144
    best_threshold = best_threshold(1,8);
    Success_rate = max(result_current_threshold(:,7))-min(result_current_threshold(:,7));
end
%% ���˵�ɹ��ʻ����������ǲ����Ѿ���С�ˣ�����ᱨ�����ǽ�������еġ�

figure;imagesc(matrix_length,[85,86]);title('ѵ����II��buffer=20����ֵ=130����ȡ�ı仯ͼ��','FontSize',16);

%% ���Ϊ�Ҷ�ֵ142.����������ǻ�����10����ѻҶ�ֵ
%% ��ͬ��������С�Ľ����δ��֪
%% 
disp('______________�������______________');

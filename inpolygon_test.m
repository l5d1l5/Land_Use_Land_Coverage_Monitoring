%% 


L = linspace(0,2.*pi,6);
% ����һ������
%% ��������������һ��ת�ò���
xv = cos(L)';
yv = sin(L)';
%% 
% rng����һ���������������
rng default
% xq = randn(1000,1);
% yq = randn(1000,1);
% ���ǰ���һ�����ݵĸ������������

% [in,on] = inpolygon(xq,yq,xv,yv);
%% ���ڵ���Ҫ������ǵ�����˳��ľͻ������= =
%% ������Ҫ��Ȼ�������ȡ��ķ��������в���
max_x_out = 200;
min_x_out =100;
max_y_out = 300;
min_y_out = 200;
cts =1;
array_points =zeros(max_x_out-min_x_out,max_y_out-min_y_out);
for i = min_x_out:max_x_out 
    for j =min_y_out: max_y_out 
        array_points(i,1)= i;
        array_points(i,2)= j;
        cts = cts+1;
    end
end
x_array = array_points(:,1);
y_array = array_points(:,2);
[in,on] = inpolygon(x_array,y_array,xv,yv);

%% Ҫ�����Ƕ���ε�����
%% Ҫ�����Ǵ���������
%% �ж�Ԫ�صĸ���  number of elements of an array 
% numel(xq(in));
% 
% numel(xq(on));
% 
% numel(xq(~in));
%% 
figure

plot(xv,yv) % polygon
axis equal

hold on
plot(x_array(in),y_array(in),'r+') % points inside
plot(x_array(~in),y_array(~in),'bo') % points outside
hold off
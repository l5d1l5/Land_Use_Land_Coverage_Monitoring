%% 


L = linspace(0,2.*pi,6);
% 绘制一个数组
%% 对于这个数组进行一个转置操作
xv = cos(L)';
yv = sin(L)';
%% 
% rng就是一个随机数的生成器
rng default
% xq = randn(1000,1);
% yq = randn(1000,1);
% 就是按照一个数据的个数生成随机数

% [in,on] = inpolygon(xq,yq,xv,yv);
%% 现在的主要问题就是点是有顺序的就会很尴尬= =
%% 我在想要不然就用随机取点的方法来进行操作
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

%% 要不就是多边形的问题
%% 要不就是待测点的问题
%% 判断元素的个数  number of elements of an array 
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
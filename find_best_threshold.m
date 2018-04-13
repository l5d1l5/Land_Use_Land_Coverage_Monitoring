function [result_current_threshold] = find_best_threshold(threshold,matrix_result_out,matrix_result_in)
%% ����Ѱ����Ѳ���
%% arthor:�δ���
%% 2018��3��25��13:50:17
%% �û��趨�Ĳ���������Ҫ���� 

%% �����趨 

%% 
[x_size_out,y_size_out ]= size(matrix_result_out);
[x_size_in ,y_size_in ] = size(matrix_result_in);
[ans,items] = size(threshold);

%% ��ÿһ����ֵ�����ж�

for item =1:items
    change_number_out = 0;
    unchange_number_out = 0;
    for i =1:x_size_out
        for j =1:y_size_out
            if(matrix_result_out(i,j) < threshold(item))
                unchange_number_out = unchange_number_out +1;
            else 
                change_number_out = change_number_out +1;
            end
        end
    end
    result_current_threshold(item,1) =change_number_out;
    result_current_threshold(item,2) =unchange_number_out;
    result_current_threshold(item,3) = change_number_out+unchange_number_out ;
    change_number_in =0;
    unchange_number_in =0;
    % �ǵ�ǰ�Ĵ�����ı仯���
    for i = 1:x_size_in 
        for j =1:y_size_in
            if(matrix_result_in(i,j) < threshold(item))
                unchange_number_in =unchange_number_in+1;
            else
                change_number_in = change_number_in +1;
            end
        end
    end
    result_current_threshold(item,4) =change_number_in;
    result_current_threshold(item,5) =unchange_number_in;
    result_current_threshold(item,6) =change_number_in + unchange_number_in;
    result_current_threshold(item,7) =(-1)*(change_number_in-(change_number_out-change_number_in))/(change_number_in + unchange_number_in);
    result_current_threshold(item,8) = threshold(item);
end
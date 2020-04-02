% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% y =  a * sin (b * x)

speed = 0.3;

drone_count = 6;
random_position = [];

real_x = [];
real_y = [];
for cnt=1:drone_count
    real_x = [real_x, []];
    real_y = [real_y, []];
    random_position = [random_position, cnt-0.5];
end
%     random_position = [random_position, cnt-1];

% file_array = [];
% for file_index = 1:drone_count
%     string = "code_txt/left_sin_wave_rtk" + num2str(file_index + 5) + ".txt";
%     temp_file = fopen(string, 'w');
%     file_array = [file_array, temp_file];
% end

offset_x = -25; % -3 % -25
offset_y = 0; % -7.5 % 0

freq_2 = 4.5;
amp_2 = 3;

for iter = 0:60 % 1 command per 1 sec
    x = [];
    y = [];
    
    time_shift = zeros(1, drone_count) + (iter * 0.5);
    
    x = time_shift;
    
    if iter < 30
        amp = 6 - 1/10*iter;
        freq = 6 - 1/20*iter;
        y = amp * sin((time_shift+pi*freq/2) / freq_2) + random_position;
    else
        y = amp_2 * sin((time_shift+pi*freq_2/2) / freq_2) + random_position;
    end
    
    x = x .* 3/4;
    y = y .* 1;
    
    x = x + offset_x;
    y = y + offset_y;
    
    for cnt=1:drone_count
        real_x(cnt, iter+1) = x(cnt);
        real_y(cnt, iter+1) = y(cnt);
    end
    
%     plot(x, y, 'r*')
%     axis([-25 25 -25 25]);
%     hold on
%     drawnow;    
%     grid

%     if iter == 0
%         for file_index = 1:drone_count
%             fprintf(file_array(file_index), '{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,       0,      255,      ''b'',        0,        0,        0},\r\n', -x(file_index), y(file_index), 49+file_index);
%             fprintf(file_array(file_index), '{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,      40,        0,      ''b'',        0,        0,        0},\r\n', -x(file_index), y(file_index), 49+file_index);
%         end
%     end
% 
%     for file_index = 1:drone_count
%         if rand() < 0.3
%             fprintf(file_array(file_index),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,        0,      ''w'',        0,        0,        0},\r\n', -x(file_index), y(file_index), 49+file_index, iter*speed+45);
%         elseif rand() < 0.8
%             fprintf(file_array(file_index),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''w'',        0,        0,        0},\r\n', -x(file_index), y(file_index), 49+file_index, iter*speed+45);
%         else
%             fprintf(file_array(file_index),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''y'',        0,        0,        0},\r\n', -x(file_index), y(file_index), 49+file_index, iter*speed+45);
%         end
%     end
end

center_pos_x = x(1);
center_pos_y = y(1) - 2;

max_x = x(drone_count) - center_pos_x;
max_y = y(drone_count) - center_pos_y;

angle_rate = -0.4 / sqrt((max_x * max_x) + (max_y * max_y));
    
for t = 1:34
    t = t*0.3;
    [x, y] = rotation_function_by_center_point(x, y, center_pos_x, center_pos_y, angle_rate);

    blank_x = size(real_x, 2);
    blank_y = size(real_y, 2);
    
    for cnt=1:drone_count
        
        real_x(cnt, blank_x+1) = x(cnt);
        real_y(cnt, blank_y+1) = y(cnt);
    end
    
%     plot(x, y, 'r*')
%     axis([-25 25 -25 25]);
%     hold on
%     drawnow;    
%     grid

%     for file_index = 1:drone_count
%         if rand() < 0.3
%             fprintf(file_array(file_index),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,        0,      ''w'',        0,        0,        0},\r\n', -x(file_index), y(file_index), 49 + file_index, t+45+60*speed);
%         elseif rand() < 0.8
%             fprintf(file_array(file_index),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''w'',        0,        0,        0},\r\n', -x(file_index), y(file_index), 49 + file_index, t+45+60*speed);
%         else
%             fprintf(file_array(file_index),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''y'',        0,        0,        0},\r\n', -x(file_index), y(file_index), 49 + file_index, t+45+60*speed);
%         end
%     end
end
     
% for file_index = 1:drone_count
% 	fprintf(file_array(file_index), '{       -1,       0,       0,%8.3f,        0,        0,        0,        0,        0,%8.3f,        0,      ''g'',        0,        0,        0},\r\n', 9 + file_index, 45+95*speed);
%     fprintf(file_array(file_index), '{       -1,       0,       0,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''g'',        0,        0,        0},\r\n', 9 + file_index, 45+95*speed + 5);
%     fclose(file_array(file_index));
% end

% left sin wave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% right sin wave
right_sin_center_x = -1.5;
right_sin_center_y = -1.0;
right_sin_theta = 170 * pi / 180;

right_sin_offset_x = 1;
right_sin_offset_y = 1;

rot_real_x = [];
rot_real_y = [];

for cnt=1:drone_count
    [temp_x, temp_y] = rotation_function_by_center_point(real_x(cnt,:), real_y(cnt,:), right_sin_center_x, right_sin_center_y, right_sin_theta);
    rot_real_x(cnt,:) = temp_x;
    rot_real_y(cnt,:) = temp_y;
end

for cnt=1:drone_count
    if cnt==1 || cnt==5
        rot_real_x(cnt, 1:14) = rot_real_x(cnt, 14);
        rot_real_y(cnt, 1:14) = rot_real_y(cnt, 14);
        
        rot_real_x(cnt, :) = flip(rot_real_x(cnt, :)) + right_sin_offset_x;
        rot_real_y(cnt, :) = flip(rot_real_y(cnt, :)) + right_sin_offset_y;
    elseif cnt==2 || cnt==4
        rot_real_x(cnt, 1:12) = rot_real_x(cnt, 12);
        rot_real_y(cnt, 1:12) = rot_real_y(cnt, 12);
        
        rot_real_x(cnt, :) = flip(rot_real_x(cnt, :)) + right_sin_offset_x;
        rot_real_y(cnt, :) = flip(rot_real_y(cnt, :)) + right_sin_offset_y;
    else
        rot_real_x(cnt, 1:10) = rot_real_x(cnt, 10);
        rot_real_y(cnt, 1:10) = rot_real_y(cnt, 10);
        
        rot_real_x(cnt, :) = flip(rot_real_x(cnt, :)) + right_sin_offset_x;
        rot_real_y(cnt, :) = flip(rot_real_y(cnt, :)) + right_sin_offset_y;
    end
end

% for cnt=1:drone_count
%     plot(rot_real_x(cnt, :), rot_real_y(cnt, :), 'r*')
%     axis([-25 25 -25 25]);
%     hold on
%     drawnow;    
%     grid
% end


% file_array = [];
% for file_index = 1:drone_count
%     string = "code_txt/right_sin_wave_rtk" + num2str(file_index) + ".txt";
%     temp_file = fopen(string, 'w');
%     file_array = [file_array, temp_file];
% end
% 
% for cnt=1:drone_count
%     fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,        3,      255,      ''b'',        0,        0,        0},\r\n', -rot_real_x(cnt, 1), rot_real_y(cnt, 1), 44+cnt);
%     fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,       40,        0,      ''b'',        0,        0,        0},\r\n', -rot_real_x(cnt, 1), rot_real_y(cnt, 1), 44+cnt);
% end
% 
% for iter=1:length(rot_real_x(1,:))
%    for cnt=1:drone_count
%        if cnt==1 || cnt==5
%            if rand() < 0.3 || iter > length(rot_real_x(1,:)) - 13
%                fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,        0,      ''w'',        0,        0,        0},\r\n', -rot_real_x(cnt, iter), rot_real_y(cnt, iter), 44+cnt, (iter-1)*speed+45);
%            elseif rand() < 0.8
%                fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''w'',        0,        0,        0},\r\n', -rot_real_x(cnt, iter), rot_real_y(cnt, iter), 44+cnt, (iter-1)*speed+45);
%            else
%                fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''y'',        0,        0,        0},\r\n', -rot_real_x(cnt, iter), rot_real_y(cnt, iter), 44+cnt, (iter-1)*speed+45);
%            end
%        elseif cnt==2 || cnt==4
%            if rand() < 0.3 || iter > length(rot_real_x(1,:)) - 11
%                fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,        0,      ''w'',        0,        0,        0},\r\n', -rot_real_x(cnt, iter), rot_real_y(cnt, iter), 44+cnt, (iter-1)*speed+45);
%            elseif rand() < 0.8
%                fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''w'',        0,        0,        0},\r\n', -rot_real_x(cnt, iter), rot_real_y(cnt, iter), 44+cnt, (iter-1)*speed+45);
%            else
%                fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''y'',        0,        0,        0},\r\n', -rot_real_x(cnt, iter), rot_real_y(cnt, iter), 44+cnt, (iter-1)*speed+45);
%            end
%        else
%            if rand() < 0.3 || iter > length(rot_real_x(1,:)) - 9
%                fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,        0,      ''w'',        0,        0,        0},\r\n', -rot_real_x(cnt, iter), rot_real_y(cnt, iter), 44+cnt, (iter-1)*speed+45);
%            elseif rand() < 0.8
%                fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''w'',        0,        0,        0},\r\n', -rot_real_x(cnt, iter), rot_real_y(cnt, iter), 44+cnt, (iter-1)*speed+45);
%            else            
%                fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''y'',        0,        0,        0},\r\n', -rot_real_x(cnt, iter), rot_real_y(cnt, iter), 44+cnt, (iter-1)*speed+45);
%            end
%        end
%     end
% end
% 
% for cnt=1:drone_count
%     fprintf(file_array(cnt), '{       -1,       0,       0,%8.3f,        0,        0,        0,        0,        0,%8.3f,        0,      ''g'',        0,        0,        0},\r\n', 4+cnt, 45+length(rot_real_x(1,:))*speed);
%     fprintf(file_array(cnt), '{       -1,       0,       0,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''g'',        0,        0,        0},\r\n', 4+cnt, 45+length(rot_real_x(1,:))*speed+5);
%     fclose(file_array(cnt)); 
% end

% % right sin wave
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % one take sin

one_take_sin_x = [];
one_take_sin_y = [];

rev_take_sin_x = [];
rev_take_sin_y = [];

for cnt=1:drone_count
    one_take_sin_x = [one_take_sin_x; [real_x(cnt, :), rot_real_x(cnt, :)]];
    one_take_sin_y = [one_take_sin_y; [real_y(cnt, :), rot_real_y(cnt, :)]];
    
    rev_take_sin_x = [rev_take_sin_x; flip(one_take_sin_x(cnt, :))];
    rev_take_sin_y = [rev_take_sin_y; flip(one_take_sin_y(cnt, :))];
end

for cnt=1:drone_count
    plot(one_take_sin_x(cnt, :), one_take_sin_y(cnt, :), 'r*')
    axis([-25 25 -25 25]);
    hold on
    drawnow;    
    grid
end


% file_array = [];
% for file_index = 1:drone_count
%     string = "code_txt/one_take_sin_wave_rtk" + num2str(file_index) + ".txt";
%     temp_file = fopen(string, 'w');
%     file_array = [file_array, temp_file];
% end
% 
% 
% for cnt=1:drone_count
%     fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,       95,        0,      ''b'',        0,        0,        0},\r\n', -one_take_sin_x(cnt, 1), one_take_sin_y(cnt, 1), 44+cnt);
% end
% 
% % forward left sin
% for iter=1:length(one_take_sin_x(1, :))/2
%     write_mission_txt(file_array, drone_count, one_take_sin_x, one_take_sin_y, 44, iter, (iter-1)*speed+115);
% end
% 
% % forward left to right
% write_mission_txt(file_array, drone_count, one_take_sin_x, one_take_sin_y, 44, length(one_take_sin_x(1, :))/2+1, 143.5);
% 
% % forward right sin
% for iter=length(one_take_sin_x(cnt, :))/2+1:length(one_take_sin_x(cnt, :))
%     for cnt=1:drone_count
%         if cnt==1 || cnt==5
%             write_mission_txt_constrain(file_array, cnt, one_take_sin_x, one_take_sin_y, 44, iter, (iter-1)*speed+118, iter > length(one_take_sin_x(cnt, :)) - 13);
%         elseif cnt==2 || cnt==4
%             write_mission_txt_constrain(file_array, cnt, one_take_sin_x, one_take_sin_y, 44, iter, (iter-1)*speed+118, iter > length(one_take_sin_x(cnt, :)) - 11);
%         else
%             write_mission_txt_constrain(file_array, cnt, one_take_sin_x, one_take_sin_y, 44, iter, (iter-1)*speed+118, iter > length(one_take_sin_x(cnt, :)) - 9);
%         end
%     end
% end
% 
% % Backward right sin
% for iter=1:length(one_take_sin_x(1, :))/2
%     for cnt=1:drone_count
%         if cnt==1 || cnt==5
%             write_mission_txt_constrain(file_array, cnt, rev_take_sin_x, rev_take_sin_y, 44, iter, (iter-1)*speed+175, iter < 13);
%         elseif cnt==2 || cnt==4
%             write_mission_txt_constrain(file_array, cnt, rev_take_sin_x, rev_take_sin_y, 44, iter, (iter-1)*speed+175, iter < 11);
%         else
%             write_mission_txt_constrain(file_array, cnt, rev_take_sin_x, rev_take_sin_y, 44, iter, (iter-1)*speed+175, iter < 9);
%         end
%     end
% end
% 
% % Backward right to left
% write_mission_txt(file_array, drone_count, rev_take_sin_x, rev_take_sin_y, 44, length(rev_take_sin_y(1, :))/2 + 1, (length(rev_take_sin_y(1, :))/2)*speed+175);
% 
% % Backward left sin
% for iter=length(rev_take_sin_x(1, :))/2+1:length(rev_take_sin_x(1, :))
%     write_mission_txt(file_array, drone_count, rev_take_sin_x, rev_take_sin_y, 44, iter, (iter-1)*speed+178);
% end
% 
% for cnt=1:drone_count
%     fprintf(file_array(cnt), '{       -1,       0,       0,%8.3f,        0,        0,        0,        0,        0,%8.3f,        0,      ''g'',        0,        0,        0},\r\n', 4 + cnt, length(rev_take_sin_x(1, :))*speed + 178);
%     fprintf(file_array(cnt), '{       -1,       0,       0,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''g'',        0,        0,        0},\r\n', 4 + cnt, length(rev_take_sin_x(1, :))*speed + 183);
%     fclose(file_array(cnt)); 
% end

% one take sin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function
function [output_rx, output_ry] = rotation_function_by_center_point(input_x, input_y, center_x, center_y, input_theta)
    output_rx = (input_x-center_x).*cos(input_theta)-(input_y-center_y).*sin(input_theta) + center_x;
    output_ry = (input_x-center_x).*sin(input_theta)+(input_y-center_y).*cos(input_theta) + center_y;
end

function [output_rx, output_ry] = rotation_function(input_x, input_y, input_theta)
    output_rx = input_x.*cos(input_theta)-input_y.*sin(input_theta);
    output_ry = input_x.*sin(input_theta)+input_y.*cos(input_theta);
end

function write_mission_txt(file_array, cnt_drone, input_x, input_y, input_z, iter, start_time)
    for cnt=1:cnt_drone
        if rand() < 0.3
            fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,        0,      ''w'',        0,        0,        0},\r\n', -input_x(cnt, iter), input_y(cnt, iter), input_z+cnt, start_time);
        elseif rand() < 0.8
            fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''w'',        0,        0,        0},\r\n', -input_x(cnt, iter), input_y(cnt, iter), input_z+cnt, start_time);
        else
            fprintf(file_array(cnt),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''y'',        0,        0,        0},\r\n', -input_x(cnt, iter), input_y(cnt, iter), input_z+cnt, start_time);
        end
    end
end

function write_mission_txt_constrain(file_array, cnt_drone, input_x, input_y, input_z, iter, start_time, constrain)
    if rand() < 0.3 || constrain
        fprintf(file_array(cnt_drone),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,        0,      ''w'',        0,        0,        0},\r\n', -input_x(cnt_drone, iter), input_y(cnt_drone, iter), input_z+cnt_drone, start_time);
    elseif rand() < 0.8
        fprintf(file_array(cnt_drone),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''w'',        0,        0,        0},\r\n', -input_x(cnt_drone, iter), input_y(cnt_drone, iter), input_z+cnt_drone, start_time);
    else
        fprintf(file_array(cnt_drone),'{        0,%8.3f,%8.3f,%8.3f,        0,        0,        0,        0,        0,%8.3f,      255,      ''y'',        0,        0,        0},\r\n', -input_x(cnt_drone, iter), input_y(cnt_drone, iter), input_z+cnt_drone, start_time);
    end
end
% function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

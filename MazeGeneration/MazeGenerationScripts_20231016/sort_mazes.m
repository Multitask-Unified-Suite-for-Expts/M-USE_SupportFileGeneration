function sort_mazes(all_maze_info_data, all_maze_data)
    
    % Iterate through every maze length in the library
    for maze_length = 2:25
        filter_and_save_mazes(all_maze_info_data, all_maze_data, maze_length);
    end
end
function filter_and_save_mazes(maze_info, mazes, maze_length)
    for maze_turns = 0:12
        % Define the condition for the 7th and 8th columns (maze_turns & maze_length)
        condition = (maze_info(:, 7) == maze_turns) & (maze_info(:, 8) == maze_length);
        
        % Use logical indexing to filter rows that meet the condition
        filtered_maze_info = maze_info(condition, :);
        
        % Use the filtered indices to select mazes
        filtered_mazes = mazes(condition, :);

        if(height(filtered_mazes) ~= 0)
        
            % Create the directory path using sprintf
            directory_path = sprintf('L%d', maze_length);
    
            % Check if the directory exists; if not, create it
            if ~exist(directory_path, 'dir')
                mkdir(directory_path);
            end
    
            % Create the file path using sprintf
            file_path = sprintf('%s/T%d.mat', directory_path, maze_turns);
    
            % Save the filtered mazes to the specified file
            save(file_path, 'filtered_mazes');
        end
    end
end





function count = countMatchingItems(value, matrix)
    % Check if there are items in the 7th column matching the specified value
    matching_rows = matrix(:, 7) == value;
    % matching_rows_idx = find(matching_rows);

    % zero_turn_mazes = total_paths(matching_rows_idx);
    % disp(zero_turn_mazes)
    % Count the number of matching items
    count = sum(matching_rows);
end





function [all_maze_data, all_maze_info_data] = merge_and_classify_maze_library()
    % Define the prefix for maze and maze_info files
    maze_file_prefix = 'saved_mazes_';
    maze_info_file_prefix = 'saved_mazes_info_';

    % Initialize variables to find the maximum file number
    max_maze_file_number = 0;
    max_maze_info_file_number = 0;

    % Use the current directory or specify the directory path
    directory_path = './'; % Change this to the directory containing your files

    % List the files in the directory
    file_list = dir(directory_path);

    % Iterate through the files to find the maximum numbers
    for i = 1:length(file_list)
        filename = file_list(i).name;
        if startsWith(filename, maze_file_prefix)
            file_number = str2double(filename(length(maze_file_prefix) + 1:end - 4));
            max_maze_file_number = max(max_maze_file_number, file_number);
        elseif startsWith(filename, maze_info_file_prefix)
            file_number = str2double(filename(length(maze_info_file_prefix) + 1:end - 4));
            max_maze_info_file_number = max(max_maze_info_file_number, file_number);
        end
    end

    % Determine the range based on the maximum numbers found
    start_index = 1;
    end_index = max(max_maze_file_number, max_maze_info_file_number);

    % Initialize cell arrays to store the loaded data
    all_maze_data = cell(1, end_index);
    all_maze_info_data = cell(1, end_index);

    tic;
    for i = start_index:end_index
        % Generate the file name for the current iteration
        maze_filename = sprintf('%s%d.mat', maze_file_prefix, i);
        maze_info_filename = sprintf('%s%d.mat', maze_info_file_prefix, i);

        % Check if the files exist before attempting to load them
        if exist(maze_filename, 'file') == 2 && exist(maze_info_filename, 'file') == 2
            % Load the data from the current files
            loaded_maze_data = load(maze_filename);
            loaded_maze_info_data = load(maze_info_filename);

            % Extract the variables from the loaded_data structure
            current_maze_data = loaded_maze_data.all_paths;
            current_maze_info_data = loaded_maze_info_data.all_paths_info;

            % Store the current data in the cell arrays
            all_maze_data{i} = current_maze_data;
            all_maze_info_data{i} = current_maze_info_data;

            if mod(i, 50) == 0
                elapsed_time = toc;
                fprintf('Current file: %s \tElapsed Time: %0.2f\n', maze_filename, elapsed_time);
                tic;
            end
        end
    end

    % Combine all the loaded data into a single variable (if they are of the same type)
    all_maze_data = cat(1, all_maze_data{:});
    all_maze_info_data = cat(1, all_maze_info_data{:});

    save('all_mazes', 'all_maze_data');
    save('all_mazes_info', 'all_maze_info_data');

    sort_mazes(all_maze_info_data, all_maze_data);
end

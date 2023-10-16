function write_maze_configs(transfer_data, maze_output_file, mazedef_output_file)
if exist(mazedef_output_file, 'file') ~= 2 || dir(mazedef_output_file).bytes == 0
    % File doesn't exist or if it is empty
    fid_maze_def = fopen(mazedef_output_file, 'w');
    fprintf(fid_maze_def, 'mDims\tmNumTurns\tmNumSquares\tmStart\tmFinish\tmName\n');
    fclose(fid_maze_def);
end
maze_def_writer(transfer_data, mazedef_output_file, maze_output_file);
end

%%
function json = write_json_maze(maze)
s = struct('sideRestricted', maze.sideRestricted, 'mDims', maze.mDims , 'mPath', maze.mPath,'mStart', maze.mStart, 'mFinish', maze.mFinish, ...
    "mNumTurns", maze.mNumTurns, "mNumSquares", maze.mNumSquares);
json = jsonencode(s);
end

function transfer_data = maze_def_writer(transfer_data, mazedef_output_file, maze_output_file)

fid_maze_def = fopen(mazedef_output_file, "a");

% write each row
for k=1:length(transfer_data(:,1))
    % Read in the file using the 'readtable' function
    data = readtable(mazedef_output_file, 'Delimiter', '\t');

    % Find the column index containing the string to search for
    column_index = find(strcmp(data.Properties.VariableNames, 'mName'));
    mazeid = 0;
    search_string =  sprintf('%s_%08i',transfer_data{k,7}, mazeid);
    while any(strcmp(data{:, column_index}, search_string))
        % Continue searching and incrementing the name until a unique id is
        % found
        mazeid = mazeid + 1;
        search_string = sprintf('%s_%08i',transfer_data{k,7}, mazeid);
    end
    transfer_data{k,7} = search_string;
    fprintf(fid_maze_def,'[%d,%d]\t%d\t%d\t%s\t%s\t%s\n',transfer_data{k,1}(1), transfer_data{k,1}(2), transfer_data{k,5}, transfer_data{k,6}, transfer_data{k,2},transfer_data{k,3}, transfer_data{k,7});
    
    % Convert the coordinates of the path to chess coordinates
    currPath = transfer_data{k,4};
    chessCoords = find_path_chess_coords(currPath);
    
    % Write the json file that contains the individual maze details
    maze = MazeWriter("TRUE", Coord(transfer_data{k,1}(1),transfer_data{k,1}(2)), chessCoords, chessCoords(1,:), chessCoords(end,:), transfer_data{k,5}, transfer_data{k,6});
    mazeJson = write_json_maze(maze);
    
    % Store the maze in the proper place in the folder according to num turns
    filepath = sprintf(maze_output_file + "\\%d Turns", transfer_data{k,5});
    if exist(filepath, 'dir') ~= 7
        mkdir(filepath);
    end
    filename = transfer_data{k,7};
    fid_maze_folder = fopen(fullfile(filepath, filename), 'w');
    fprintf(fid_maze_folder , '%s', mazeJson);
    fclose(fid_maze_folder);

end
fclose(fid_maze_def);
end

function chessCoords = find_path_chess_coords(currPath)
% converts the points along the path to chess coordinates
    chessCoords = [];
    for j = 1:length(currPath)
        coords = Coord(currPath{j}(1), currPath{j}(2));
        chessCoord = coords.getChessNotation();
        chessCoords=[chessCoords; chessCoord];
    end
end

% function create_maze_json_file()
% 
% % Will write a line for each maze in transfer_data to the Maze Def
% %transfer_data = maze_def_writer(transfer_data, mazedef_output_file);
% 
% % Convert the coordinates of the path to chess coordinates
% chessCoords = find_chess_coords(transfer_data)
%     
% % Write the json file that contains the individualmaze details
% maze = MazeWriter("TRUE", Coord(transfer_data{idx,1}(1),transfer_data{idx,1}(2)), chessCoords, chessCoords(1,:), chessCoords(end,:), transfer_data{idx,5}, transfer_data{idx,6});
% mazeJson = write_json_maze(maze);
% 
% 
% end
# Maze Generation
## Algorithm
The scripts used to generate the maze library utilizes a **Depth-first search algorithm** to find every possible path from start to end. The first node is the start position and a visited matrix is stored in combination with the adjacent coordinates of the current node to explore all possible paths, until the end coordinate is reached which is when the path is finally stored.

![image](https://github.com/Multitask-Unified-Suite-for-Expts/M-USE_SupportFileGeneration/assets/71558911/7c19ec01-ac1f-4e4a-a1f5-1365c5dd15e4)

This algorithm is applied to every combination of start to end where the possible start and end coordinates are every point along the border of the maze. Below is an image of the possible start and end coordinates for a maze with dimensions of 6 with the associated **Algebraic notation** used to describe coordinates.
 <br/>

<img width="400" alt="image" src="https://github.com/Multitask-Unified-Suite-for-Expts/M-USE_SupportFileGeneration/assets/71558911/b139f1bd-c5e2-44d1-a6cd-b42abe68ae14">

## Scripting

The script that generates the mazes is labelled _find_all_maze_paths_logical_v6_. While the DFS algorithm is running, the mazes are appended to a local file labelled **_saved_mazes_i.mat_** while the maze details are stored in **_save_mazes_info_i.mat_** in batches of 10,000 to clear the memory of the newly generated paths in MATLAB. Once the file exceeds 400,000 maze entries, the file name is incremented and the mazes are saved and appended to a new file. 

Once all possible mazes are generated, the function _merge_and_classify_maze_library_ is called and combines all the generated **_saved_mazes_i.mat_** and **_saved_mazes_info_i.mat_** files into 2 files named **_all_mazes.mat_** and **_all_mazes_info.mat_**. These tables are filtered and stored locally by path length and number of turns. 

## Maze Library
The MazeLibrary_20231016 was generated with the following call of _find_all_maze_paths_logical_v6_ with a maze board of dimensions = 6x6, max turns = 12, max length = 25. 

```
>> find_all_maze_paths_logical_v6(6, 12, 25);
```


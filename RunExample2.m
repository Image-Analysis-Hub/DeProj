%% Example de-projection script, using a cell result structure and a mesh.

%% Clear all.

close all
clear
clc

%% Parameters, scripts and files location.

% Add DeProj functions to the path.
addpath('./src')

% Where are the images.
root_folder = 'samples';

% The segmentation results. Here we use the results from Y. Bellaiche lab
% analysis software. The results must contain a CELL, FRAME, VERTICES and
% SIDES structures.
segmentation_filename   = 'SIA_161210_gfapnlsg_Backup_001.mat';

% The tissue surface mesh. It must be a mesh mapping the tissue surface, 
% openedd at the tissue borders.
mesh_filename           = 'SimplifiedMesh.ply';

% The physical unit of length must be specified (not stored elsewhere).
units = 'µm';

%% Read files.

% Segmentation results.
fprintf('Opening segmentation file: %s\n', segmentation_filename )
seg = load( fullfile( root_folder, segmentation_filename ) );

% Path to mesh file.
mesh_file_path = fullfile( root_folder, mesh_filename );

%% Create deproj instance.

dpr = deproj.from_bellaiche( ...
    seg.CELLS, ...
    seg.FRAME, ...
    seg.SIDES, ...
    seg.VERTICES, ...
    mesh_file_path, ...
    units  );

%% Plot morphological parameters.

close all

fprintf( 'Plotting the cell sizes.\n' )
dpr.figure_cell_sizes;

fprintf( 'Plotting the tissue orientation.\n' )
dpr.figure_tissue_orientation;

fprintf( 'Plotting the tissue local curvature.\n' )
dpr.figure_curvatures;

fprintf( 'Plotting the cell elongation and direction.\n' )
dpr.figure_cell_elongation;

fprintf( 'Plotting the impact of projection distorsion.\n' )
dpr.figure_distorsions;

fprintf( 'Finished.\n' )

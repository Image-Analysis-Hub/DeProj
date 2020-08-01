%% Example de-projection script, using a cell result structure and a mesh.

%% Clear all.

close all
clear
clc

%% Parameters, scripts and files location.

% Add DeProj functions to the path.
addpath('./src')

% Where are the files.
root_folder = 'samples';

% The segmentation results. Here we use the results from Y. Bellaiche lab
% analysis software. The results must contain a CELLS, FRAME, VERTICES and
% SIDES structures.
segmentation_filename   = 'AdultZebrafishBrainSeg.mat';

% The tissue surface mesh. It must be a mesh mapping the tissue surface, 
% openedd at the tissue borders.
mesh_filename           = 'AdultZebrafishBrainSimplifiedMesh.ply';

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
scale_bar_length = 50; % um.

fprintf( 'Plotting the cell sizes.\n' )
dpr.figure_cell_sizes( scale_bar_length );

fprintf( 'Plotting the tissue orientation.\n' )
dpr.figure_tissue_orientation( scale_bar_length );

fprintf( 'Plotting the tissue local curvature.\n' )
dpr.figure_curvatures( scale_bar_length );

fprintf( 'Plotting the cell elongation and direction.\n' )
dpr.figure_cell_elongation( scale_bar_length );

fprintf( 'Plotting the impact of projection distorsion.\n' )
dpr.figure_distorsions( scale_bar_length );

fprintf( 'Plotting the topology figure.\n' )
dpr.figure_topology( scale_bar_length );

fprintf( 'Finished.\n' )

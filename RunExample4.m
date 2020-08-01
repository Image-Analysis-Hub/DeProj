%% Display an image on the tissue surface.
% We take the same data than for the first example and regenerate the
% deproj object for it. 
%
% Then we plot the segmentation results (in 3D) and map the image of the 2D
% projection image on the tissue surface. 


%% Clear all.

close all
clear
clc

%% Parameters, scripts and files location.

% Same things that for example 1. I will skip comments.
addpath('./src')
root_folder = 'samples';
mask_filename       = 'Segmentation-2.tif';
heightmap_filename  = 'HeightMap-2.tif';
image_file_path     = 'static/Projection-2.png';
pixel_size = 0.183; % µm
units = 'µm';
voxel_depth = 1.; % µm
prune_zeros = true;
inpaint_zeros = true;
invert_z = true;

%% Read files.

% ImageJ mask.
fprintf('Opening mask image: %s\n', mask_filename )
I = imread( fullfile( root_folder, mask_filename ) );

fprintf('Opening height-map image: %s\n', heightmap_filename )
H = imread( fullfile( root_folder, heightmap_filename ) );

%% Create deproj instance.

dpr = deproj.from_heightmap( ...
    I, ...
    H, ...
    pixel_size, ...
    voxel_depth, ...
    units, ...
    invert_z, ...    
    inpaint_zeros, ...
    prune_zeros );

%% Load the image to map and display it.

% The image to display must be a 2D image, colored of grayscale. Ideally it
% has the same number of pixels and the same pixel size that the
% segmentation image that helped creating the deproj object. 
% What really matter is that we can have share X,Y coordinates thanks to
% the pixel size and origin of the image.
fprintf('Opening the image to map: %s\n', image_file_path )
% Since it is a color image, we also load the LUT in the Tmap variable.
[ T, Tmap ] = imread( image_file_path );

figure 
hold on
axis equal

% Plot the segmentation. If we pass 'w' to the 'plot_values_contour', the
% cell faces will be transparent and their border will be painted in white.
hc = dpr.plot_values_contour( 'w', gca );
hc.LineWidth = 1;

% This is the the command to plot the image on the tissue surface. Since we
% have a color image, we pass the 'Tmap' array that contains the LUT of the
% image. If you have a grayscale image, just pass the empty array [].
dpr.texture_image( T, Tmap, pixel_size );

% Put some lighting and orientation so that we can get a feeling of the
% tissue ripples. 
axis off
lighting gouraud
light

el = 23;
az = -73;
view( az, el )
axis tight

title( 'Texturing the projection on the segmentation results.', ...
    'FontWeight', 'normal', ...
    'Interpreter', 'none' )

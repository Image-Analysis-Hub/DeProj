classdef deproj
    %DEPROJ Manage a collection of epicells.
    
    properties
        epicells
        junction_graph
        units
    end
    
    methods
        function obj = deproj( epicells, junction_graph, units )
            obj.epicells = epicells;
            obj.junction_graph = junction_graph;
            obj.units = units;
        end
    end
    
    %% Plotting routines.
    methods
        
        %% Exports.
        
        % Export masurements to a table.
        T = to_table( obj )
        
        % Exports results to a spreadsheet file.
        to_file( obj, file_name, include_header )
        
        %% Conversion between MATLAB objects.
        
        % Returns the faces and vertices of the junction graph of a instance.
        [ V, F ] = graph_to_VF( obj )
        
        % Returns the cells boundary polygons as 3 matrices padded by NaNs.
        [ X, Y, Z ] = to_matrices( obj )

        %% Generate figures.
        
        % Figure with the local tissue orientation for a collection of epicells.
        [ hf, ax1, ax2, ax3 ] = figure_tissue_orientation( obj, scale_bar_length )
        
        % Plot the cell elongation and 2D orientation with cells as 2D ellipses.
        [ hf, ax1, ax2 ] = figure_cell_elongation( obj, scale_bar_length )
        
        % Figure with the local curvaure for a collection of epicells.
        [ hf, ax1, ax2, ax3 ] = figure_curvatures( obj, scale_bar_length )
        
        % Figure with the cells area and perimeter.
        [ hf, ax1, ax2 ] = figure_cell_sizes( obj, scale_bar_length )
        
        % Figure with the error on uncorrected cells area and perimeter.
        [ hf, ax1, ax2 ] = figure_distorsions( obj, scale_bar_length )
        
        % Figure with the number of neighbors around each cell.
        [ hf, ax ] = figure_topology( obj, scale_bar_length )

        %% Helpers.
        % They are public in case of.
        
        % Add the epicell ids to the specified plot axes.
        hts = add_plot_ids( obj, ax )
        
        % Add a scale-bar to the plot.
        [ hsb, ht ] = add_plot_scalebar( obj, length, ax )
        
        % Plot the tissue with the cell exact contours, colored by the specified values.
        hts = plot_values_contour( obj, values, ax )
        
        % Plot the tissue with cells as ellipses, colored by the specified values.
        hts = plot_values_ellipse( obj, values, ax )
        
        % Plot the tissue with the cell contour approximated by the junctions, colored by the specified values.
        hts = plot_values_junction( obj, values, ax )
        
        % Plot text at cell centers.
        hts = plot_text( obj, texts, ax )
      
    end
    
     %% Public static methods: builders & util.
    methods ( Access = public, Hidden = false, Static = true )
        
        % Returns a deproj object built from segmentation and height-map.
        obj = from_heightmap( I, ...
            H, ...
            pixel_size, ...
            voxel_depth, ...
            units, ...
            invert_z, ...
            inpaint_zeros, ...
            prune_zeros );
        
        % Returns a deproj object built from the results of the tool
        % from Yohannes Bellaiche lab.
        obj = from_bellaiche( ...
            cells, ...
            frame, ...
            sides, ...
            vertices, ...
            voxel_depth, ...
            units )
        
        % Returns the seismic colormap.
        cmap = cmap_seismic();
        
        % Compute local curvature from the smoothed height-map.
        [ curvMean, curvGauss, curvK1, curvK2 ] = compute_curvatures( H, object_scale, pixel_size, voxel_depth, invert_z )
        
        % Sort the points of a polygon in clockwise manner.
        [ P2, I ] = sort_polygon( P )
        
        % Sort x,y coordinates along a continuous contour.
        P2 = find_countour( P )

        % Read a PLY file.
        [ V, F, comments ] = ply_read( file_path )

        % Create a height-map from a mesh.
        [ H, min_y, min_x ] = mesh_to_heightmap( V, pixel_size )

    end
    
    %% Private static methods: utilities.
    methods ( Access = private, Hidden = true, Static = true )
        
        % Returns the Z position of points taken from a height-map.
        z_coords = get_z( P, H, pixel_size, voxel_depth )
        
        % Returns the cells from a BW image with ridges.
        [ objects, junction_graph ] = mask_to_objects( I, downsample )
        
        
    end
end


function [ hf, ax ] = figure_topology( obj, scale_bar_length )
%FIGURE_TOPOLOGY Figure with the number of neighbors around each cell.

    if nargin < 2
        scale_bar_length = 10;
    end

    hf = figure( 'Position', [ 1204 20 600 450 ] );
    
    epicells = obj.epicells;
    
    ax = gca;
    hold on
    axis equal
    n_neighbors = vertcat( epicells.n_neighbors );
    obj.plot_values_junction( n_neighbors, ax );
    
    colorbar
    
    obj.add_plot_scalebar( scale_bar_length, ax );
    
    axis( ax, 'off' )
    
    title( ax, 'Number of neighbors around a cell', ...
        'FontWeight', 'normal', ...
        'Interpreter', 'none' )

end


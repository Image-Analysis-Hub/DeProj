function [ hf, ax1, ax2 ] = figure_cell_elongation( obj, scale_bar_length )
%FIGURE_CELL_ORIENTATION Plot the cell elongation and 2D orientation with cells as 2D ellipses.

    if nargin < 2
        scale_bar_length = 10;
    end

    hf = figure( 'Position', [ 1204 20 600 650 ] );
    
    %% Direction.
    
    ax1 = subplot( 2, 1, 1 );
    cmap1 = 'hsv';
    colormap( cmap1 )
    hold on
    axis equal
    
    values1 = rad2deg( [ obj.epicells.proj_direction ]' );
    obj.plot_values_ellipse( values1, cmap1, ax1, -90, 90 );

    axis( ax1, 'off' )
    colorbar( ax1 )

    title( ax1, 'Main orientation of cell (º)', ...
        'FontWeight', 'normal' )

    %% Elongation.
    
    ax2 = subplot( 2, 1, 2 );
    hold on
    axis equal
    
    values2 = [ obj.epicells.eccentricity ]';
    cmap2 = 'parula';
    obj.plot_values_ellipse( values2, cmap2, ax2, 0, 1 );

    axis( ax2, 'off' )
    colorbar( ax2 )

    title( ax2, 'Eccentricity', ...
        'FontWeight', 'normal' )
    
    
    add_plot_scalebar(  obj, scale_bar_length, ax2 );



end


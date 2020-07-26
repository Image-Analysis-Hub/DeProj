function [ hf, ax1, ax2 ] = figure_cell_elongation( obj, scale_bar_length )
%FIGURE_CELL_ORIENTATION Plot the cell elongation and 2D orientation with cells as 2D ellipses.

    if nargin < 2
        scale_bar_length = 10;
    end

    hf = figure( 'Position', [ 1204 20 600 650 ] );
    
    %% Direction.
    
    ax1 = subplot( 2, 1, 1 );
    colormap( 'hsv' )
    hold on
    axis equal
    
    values1 = rad2deg( [ obj.epicells.proj_direction ]' );
    obj.plot_values_ellipse( values1, ax1 );
    set( ax1, 'CLim', [ -90 90 ] )

    axis( ax1, 'off' )
    colorbar( ax1 )

    title( ax1, 'Main orientation of cell (º)', ...
        'FontWeight', 'normal' )

    %% Elongation.
    
    ax2 = subplot( 2, 1, 2 );
    hold on
    axis equal
    
    values2 = [ obj.epicells.eccentricity ]';
    obj.plot_values_ellipse( values2, ax2 );
    set( ax2, 'CLim', [ 0 1 ] )
    colormap(ax2, 'parula' );

    axis( ax2, 'off' )
    colorbar( ax2 )

    title( ax2, 'Eccentricity', ...
        'FontWeight', 'normal' )
    
    
    add_plot_scalebar(  obj, scale_bar_length, ax2 );
    linkaxes( [ ax1 ax2 ] )

end


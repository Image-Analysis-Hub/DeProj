function [ hf, ax1, ax2 ] = figure_cell_sizes( obj, scale_bar_length )
%FIGURE_CELL_SIZES Figure with the cells area and perimeter.

    if nargin < 2
        scale_bar_length = 10;
    end
    epicells = obj.epicells;

    hf = figure( 'Position', [ 1204 20 600 650 ] );
    
    ax1 = subplot( 2, 1, 1 );
    hold on
    axis equal
    areas = vertcat( epicells.area );   
    obj.plot_values_contour( areas, ax1 );
    colorbar
    
    ax2 = subplot( 2, 1, 2 );
    hold on
    axis equal
    perims = vertcat( epicells.perimeter );    
    obj.plot_values_contour( perims, ax2 );
    colorbar
    
    add_plot_scalebar( obj, scale_bar_length, ax2 );
    
    axis( ax1, 'off' )
    axis( ax2, 'off' )
    
    title( ax1, sprintf('Cell area (%s²)', obj.units), ...
        'FontWeight', 'normal', ...
        'Interpreter', 'none' )
    title( ax2, sprintf('Cell perimeter (%s)', obj.units), ...
        'FontWeight', 'normal', ...
        'Interpreter', 'none' )

    linkaxes( [ ax2 ax1 ] )
end


function [ hf, ax1, ax2 ] = figure_distorsions( obj, scale_bar_length )
%PLOT_DISTORSIONS Figure with the error on uncorrected cells area and perimeter.

    if nargin < 2
        scale_bar_length = 10;
    end

    hf = figure( 'Position', [ 1204 20 600 650 ] );
    
    epicells = obj.epicells;
    
    ax1 = subplot( 2, 1, 1 );
    hold on
    axis equal
    areas = vertcat( epicells.area );
    uncorr_areas = vertcat( epicells.uncorrected_area );
    err = 1 - uncorr_areas ./ areas;
    obj.plot_values_contour( 100. * err, ax1 );
    
    colorbar
    
    ax2 = subplot( 2, 1, 2 );
    hold on
    axis equal
    perims = vertcat( epicells.perimeter );
    uncorr_perims = vertcat( epicells.uncorrected_perimeter );
    err = 1 - uncorr_perims ./ perims;    
    obj.plot_values_contour( 100. * err, ax2 );
    colorbar
    
    obj.add_plot_scalebar( scale_bar_length, ax2 );
    
    axis( ax1, 'off' )
    axis( ax2, 'off' )
    
    title( ax1, 'Error on cell area (%)', ...
        'FontWeight', 'normal', ...
        'Interpreter', 'none' )
    title( ax2, 'Error on cell perimeter (%)', ...
        'FontWeight', 'normal', ...
        'Interpreter', 'none' )

    linkaxes( [ ax2 ax1 ] )
end


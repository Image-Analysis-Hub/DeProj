function [ hf, ax1 ] = figure_gaussian_curvature( obj, scale_bar_length )
%FIGURE_GAUSSIAN_CURVATURES Figure with the gaussian curvature for a collection of epicells.

    if nargin < 2
        scale_bar_length = 10;
    end
    
    epicells = obj.epicells;
    curvs = vertcat( epicells.curvatures );
    
    hf = figure( 'Position', [ 1204 20 600 1000 ] );
    
    ax1 = subplot( 1, 1, 1 );
    hold on
    axis equal
    
    gauss_curv = curvs( :, 1 );
    obj.plot_values_contour( gauss_curv, ax1 );
    
    cmap = deproj.cmap_seismic();
    colormap( ax1, cmap )
    c = colorbar(ax1, 'Location', 'EastOutside' );
    c.Label.String = sprintf('Curvature (1/%s^2)', obj.units );
    
    obj.add_plot_scalebar( scale_bar_length, ax1 );
    
    axis( ax1, 'off' )
    
    title( ax1, 'Gaussian curvature', ...
        'FontWeight', 'normal' )
    
    %linkaxes( [ ax3 ax2 ax1 ] )
end

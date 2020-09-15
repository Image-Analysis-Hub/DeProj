function [ hf, ax1, ax2, ax3 ] = figure_curvatures( obj, scale_bar_length )
%FIGURE_CURVATURES Figure with the local curvature for a collection of epicells.

    if nargin < 2
        scale_bar_length = 10;
    end
    
    epicells = obj.epicells;
    curvs = vertcat( epicells.curvatures );
    
    hf = figure( 'Position', [ 1204 20 600 1000 ] );
    
    ax1 = subplot( 3, 1, 1 );
    hold on
    axis equal
    
    mean_curv = curvs( :, 1 );
    obj.plot_values_contour( mean_curv, ax1 );
    
    ax2 = subplot( 3, 1, 2 );
    hold on
    axis equal
    
    k1_curv = curvs( :, 3 );    
    obj.plot_values_contour( k1_curv, ax2 );
    
    ax3 = subplot( 3, 1, 3 );
    hold on
    axis equal
    
    k2_curv = curvs( :, 4 );    
    obj.plot_values_contour( k2_curv, ax3 );
    
    % Collect min & max.
    cl1 = get( ax1, 'CLim' );
    cl2 = get( ax2, 'CLim' );
    cl3 = get( ax3, 'CLim' );
    min1 = cl1( 1 );
    max1 = cl1( 2 );
    min2 = cl2( 1 );
    max2 = cl2( 2 );
    min3 = cl3( 1 );
    max3 = cl3( 2 );
    minc = max( abs( [ min1, min2, min3 ] ) );
    maxc = max( abs( [ max1, max2, max3 ] ) );
    ml = max( [ minc, maxc ] );
    
    set( ax1, 'CLim', [ -ml, ml ] )
    set( ax2, 'CLim', [ -ml, ml ] )
    set( ax3, 'CLim', [ -ml, ml ] )
    cmap = deproj.cmap_seismic();
    colormap( ax1, cmap )
    colormap( ax2, cmap )
    colormap( ax3, cmap )
    c = colorbar(ax3, 'Location', 'EastOutside' );
    c.Label.String = sprintf('Curvature (1/%s)', obj.units );
    
    obj.add_plot_scalebar( scale_bar_length, ax3 );
    
    axis( ax1, 'off' )
    axis( ax2, 'off' )
    axis( ax3, 'off' )
    
    title( ax1, 'Local mean curvature', ...
        'FontWeight', 'normal' )
    title( ax2, 'First principal curvature' , ...
        'FontWeight', 'normal' )
    title( ax3, 'Second principal curvature' , ...
        'FontWeight', 'normal' )

    linkaxes( [ ax3 ax2 ax1 ] )

end


function [ hf, ax1, ax2, ax3 ] = figure_tissue_orientation( obj, scale_bar_length )
%FIGURE_ORIENTATION Figure with the local tissue orientation for a collection of epicells.

    if nargin < 2
        scale_bar_length = 10;
    end
    
    epicells = obj.epicells;
    angles = vertcat( epicells.euler_angles );

    hf = figure( 'Position', [ 1204 20 600 1000 ] );
    
    ax1 = subplot( 3, 1, 1 );
    hold on
    axis equal
    alphas = rad2deg( angles( :, 1 ) );   
    % Wrap back to 0 - 180º.
    neg_alphas = alphas < 0;
    alphas( neg_alphas ) = 180 + alphas( neg_alphas );
    obj.plot_values_contour( alphas, ax1 );
    colormap( ax1, 'hsv' )
    colorbar(ax1)

    ax2 = subplot( 3, 1, 2 );
    hold on
    axis equal
    betas = rad2deg( angles( :, 2 ) );    
    % Wrap back to 0 - 90º.
    large_betas = betas > 90;
    betas( large_betas ) = 180 - betas( large_betas );
    obj.plot_values_contour( betas, ax2 );
    colorbar(ax2)

    ax3 = subplot( 3, 1, 3 );
    hold on
    axis equal
    gammas = rad2deg( angles( :, 3 ) );    
    neg_gammas = gammas < 0;
    gammas( neg_gammas ) = 180 + gammas( neg_gammas );    
    obj.plot_values_contour( gammas, ax3 );
    colormap( ax3, 'hsv' )
    colorbar(ax3)   
    
    obj.add_plot_scalebar( scale_bar_length, ax3 );
    linkaxes( [ ax3 ax2 ax1 ] )
    
    axis( ax1, 'off' )
    axis( ax2, 'off' )
    axis( ax3, 'off' )
    
    title( ax1, 'Orientation of plane (º)', ...
        'FontWeight', 'normal' )
    title( ax2, 'Slope of plane (º)' , ...
        'FontWeight', 'normal' )
    title( ax3, 'Cell main orientation in plane (º)' , ...
        'FontWeight', 'normal' )

end


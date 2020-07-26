function hts = plot_values_ellipse( obj, values, cmap, ax, min_val_col, max_val_col )
%PLOT_VALUES_ELLIPSE Plot the tissue with cells as ellipses, colored by the specified values.
%
% INPUTS:
%
%   obj: a deproj object, with N epicells.
%
%   values - a N x 1 array with values to use for coloring.
%
%   cmap - the color-map to use for coloring. Optional, default value id
% the parula colormap.
%
%   ax - the axes to plot in. Optional, default is current axes.
%
%   min_val_col - min value to generate color. Optional, default is the
% minimal value of the specified values.
%
%   max_val_col - max value to generate color. Optional, default is the
% maximal value of the specified values.
%   
% OUTPUT:
%
%   a 2N x 1 array of handles to the ellipse and major-axis line objects.
%

    epicells = obj.epicells;
    n_objects = numel( epicells );
    hts = NaN( 2 * n_objects, 1 );

    minv = min( values );
    maxv = max( values );
    
    if nargin < 3
        cmap = 'parula';
    end
    if nargin < 4
        ax = gca;
    end
    if nargin < 5
        min_val_col = minv;
    end
    if nargin < 6
        max_val_col = maxv;
    end
       
    colors = colormap( ax, cmap );
    
    if n_objects > 1000, lw = 1; else, lw = 2; end

    idx = @(v) 1 + round( (v - min_val_col)/(max_val_col - min_val_col)  * ( size( colors, 1 ) - 1 ) );
    for i = 1 :  n_objects

        o = epicells( i );
        h1 =  o.plot_ellipse_3d( 23, ax );
        h2 =  o.plot_ellipse_3d( 3, ax );

        hts( 2 * i - 1 ) =  h1;
        hts( 2 * i ) =  h2;
        val = values( i );
        j = idx( val );
        j = max( [ 1 j ] );
        j = min( [ size( colors, 1 ) j ] );
        set( [ h1 h2 ], ...
            'Color', colors( j, : ), ...
            'LineWidth', lw )
    end
    
    set( ax, 'CLim', [ min_val_col max_val_col ] )
    
end

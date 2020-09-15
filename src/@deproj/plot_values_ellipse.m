function hts = plot_values_ellipse( obj, values, ax )
%PLOT_VALUES_ELLIPSE Plot the tissue with cells as ellipses, colored by the specified values.
%
% INPUTS:
%
%   obj: a deproj object, with N epicells.
%
%   values - a N x 1 array with values to use for coloring.
%
%   ax - the axes to plot in. Optional, default is current axes.
%
% OUTPUT:
%
%   the handle to the ellipse patch object.
%

    epicells = obj.epicells;
    n_objects = numel( epicells );
    
    if nargin < 4
        ax = gca;
    end
    
    n_points = 21;
    X = zeros( n_points + 2, n_objects );
    Y = zeros( n_points + 2, n_objects );
    Z = zeros( n_points + 2, n_objects );
    V = zeros( ( n_points + 2 ) * n_objects, 1 );
    
    if n_objects > 1000, lw = 1; else, lw = 2; end

    index = 1;
    mid = ceil( n_points / 2 );
    for i = 1 :  n_objects

        o = epicells( i );
        p = o.get_ellipse_points( n_points );        
        xp = p( :, 1 );
        yp = p( :, 2 );
        zp = p( :, 3 );
        
        X( 1 : n_points + 2, i ) = [ xp ; xp( mid ) ];
        Y( 1 : n_points + 2, i ) = [ yp ; yp( mid ) ];
        Z( 1 : n_points + 2, i ) = [ zp ; zp( mid ) ];
        V( index : index + n_points + 1 ) = values( i );
        index = index + n_points + 2;

    end
    
    hts = patch( ...
        'XData', X, ...
        'YData', Y, ...
        'ZData', Z, ...
        'FaceVertexCData', V, ...
        'EdgeColor', 'flat', ...
        'FaceColor', 'none', ...
        'LineWidth', lw, ...
        'Parent', ax );
end

function hts = plot_values_contour( obj, values, ax )
%PLOT_VALUES_CONTOUR Plot the tissue with the cell exact contours, colored by the specified values.
%
% INPUTS:
%   obj: a deproj object, with N epicells.
%   values - a N x 1 array with values to use for coloring.
%   ax - the axes to plot in.
% 
% OUTPUT:
%   a N x 1 array of handles to the cell polygon objects.
    
    epicells = obj.epicells;
    boundaries = { epicells.boundary };
    n_objects = numel( boundaries );    
    hts = NaN( n_objects, 1 );
    
    if n_objects > 1000, lw = 1; else, lw = 2; end
    
    for i = 1 :  n_objects

        p = boundaries{ i };
        val = values( i );
        hts(i ) = patch( ax, p(:,1), p(:,2), p(:,3), val, ...
            'LineWidth', lw );
    end
end

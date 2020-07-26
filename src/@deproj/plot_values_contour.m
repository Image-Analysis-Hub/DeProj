function hts = plot_values_contour( obj, values, ax )
%PLOT_VALUES_CONTOUR Plot the tissue with the cell exact contours, colored by the specified values.
%
% INPUTS:
%   obj: a deproj object, with N epicells.
%   values - a N x 1 array with values to use for coloring.
%   ax - the axes to plot in.
%
% OUTPUT:
%   the handle to the cells patch object.

    epicells = obj.epicells;
    boundaries = { epicells.boundary };

    n_objects = numel( boundaries );
    if n_objects > 1000, lw = 1; else, lw = 2; end

    [ X, Y, Z ] = obj.to_matrices();
    hts = patch( ...
        'XData', X, ...
        'YData', Y, ...
        'ZData', Z, ...
        'FaceVertexCData', values, ...
        'FaceColor', 'flat', ...
        'LineWidth', lw, ...
        'Parent', ax );

end

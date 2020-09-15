function [ H, min_y, min_x ] = mesh_to_heightmap( V, pixel_size )
%MESH_TO_HEIGHTMAP Create a height-map from a mesh.
% Of course there are plenty of restriction on the mesh for this to be
% valid. Mainly: we need the mesh to be so that there is only 1 Z for each
% X, Y couple. Secondly, the X and Y coordinates need to be positive.

    % Convert to pixel-coordinates.
    x = V( :, 1 );
    y = V( :, 2 );
    xp = x / pixel_size;
    yp = y / pixel_size;
    z = V( :, 3 ) - min( V( :, 3 ) );

    % Allocate target image.
    max_x = 1 + ceil( max( xp ) );
    max_y = 1 + ceil( max( yp ) );
    min_x = 1 + floor( min( xp ) );
    min_y = 1 + floor( min( yp ) );

    % Interpolate.
    si = scatteredInterpolant( xp, yp, z, 'linear', 'none' );

    % Create elevation on the the grid.
    [ X, Y ] = meshgrid( min_x : max_x, min_y : max_y );
    z_im = si( X(:), Y(:) );
    z_im( isnan( z_im ) ) = 0.;
    H = reshape( z_im', [ ( max_y - min_y + 1 ) ( max_x- min_x + 1  ) ] );
    
end


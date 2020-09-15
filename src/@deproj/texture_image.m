function h = texture_image( obj, T, Tmap, pixel_size, on_what )
%TEXTURE_IMAGE Display an image textured on the tissue surface.

    if nargin < 5 
        on_what = 'contour';
    end
    if nargin < 4 
        pixel_size = 1.;
    end
    
    % Get coordinates to interpolate upon.
    switch on_what
        case 'contour'
            P = double( vertcat( obj.epicells.boundary  ) );
        case 'junctions'
            P = double( obj.junction_graph.Nodes.Centroid );
        otherwise
            error( 'deproj:texture_image:UnknownPointSource', ...
                'Does not know how to texture surface on %s. Please select "contour" or "junctions".', ...
                on_what )
    end
    
    % Prune XY duplicates.
    [ ~, ia ] = unique( P( :, 1:2), 'rows' );
    P = P( ia, : );
    
    % Create the surface coordinates.
    [ X, Y ] = meshgrid( 1 : size( T , 2 ), 1 : size( T, 1 ) );
    X = X(:) .* pixel_size;
    Y = Y(:) .* pixel_size;
    
    % Collect the Z position by interpolating the Zs we have in the deproj
    % object.
    si = scatteredInterpolant( ...
        double( P( :, 1 ) ), ...
        double( P( :, 2 ) ), ...
        double( P( :, 3 ) ), ...
        'linear', ...
        'none' );
    Z = si( X, Y );
    
    % Reshape the coordinates.
    Xs = reshape( X, size( T )  );
    Ys = reshape( Y, size( T )  );
    Zs = reshape( Z, size( T )  );
    mask = isnan( Zs );
    Zs = regionfill( Zs, mask );
    
    if nargin < 3 || isempty( Tmap )
        h = warp( Xs, Ys, Zs, T );
    else
        h = warp( Xs, Ys, Zs, T, Tmap );
    end
    
end


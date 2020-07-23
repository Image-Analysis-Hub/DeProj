function P2 = sort_polygon( P )
%SORT_POLYGON Sort the points of a polygon in clockwise manner.
    
    center = mean( P );
    x = P( :, 1 ) - center( 1 );
    y = P( :, 2 ) - center( 2 );
    angles = atan2( y , x );
    
    [ ~, sort_indexes ] = sort(angles);
    P2 = P( sort_indexes, : );
    
end


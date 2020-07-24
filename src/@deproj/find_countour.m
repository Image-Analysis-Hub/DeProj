function P2 = find_countour( P )
%FIND_COUNTOUR Sort x,y coordinates along a continuous contour.

    P2 = NaN( size( P ) );
    current = 1;

    % Start point
    ps = P( 1, : );    
    set_visited( 1 )
    P2( current, : ) = ps;
    current = current + 1;
    
    % Loop.
    done = size( P, 1 ) == 1;
    while ~done

        done = current == size( P, 1 );

        id = find_next_point( ps );
        ps = P( id, : );
        set_visited( id )
        P2( current, : ) = ps;
        current = current + 1;
        
    end
    
    
    function set_visited( id )
        P( id, : ) = NaN;
    end
    
    function id = find_next_point( p0 )        
        [ ~, id ] = pdist2( P, p0, 'Euclidean', 'Smallest', 1 );
    end
    
end


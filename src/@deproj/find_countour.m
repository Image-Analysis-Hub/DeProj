function P2 = find_countour( P )
%FIND_COUNTOUR Sort x,y coordinates along a continuous contour.

    P2 = NaN( size( P ) );
    current = 1;

    D = squareform( pdist ( P ) );
    D( D == 0 ) = Inf;
    
    % Start point
    id = 1;
    ps = P( id, : );    
    P2( current, : ) = ps;
    current = current + 1;
    
    % Loop.
    done = size( P, 1 ) == 1;
    while ~done

        done = current == size( P, 1 );

        prev_id = id;
        id = find_next_point( id );
        ps = P( id, : );
        set_visited( prev_id )
        P2( current, : ) = ps;
        current = current + 1;
        
    end
    
    
    function set_visited( id )
        D( id, : ) = Inf;
        D( :, id ) = Inf;
    end
    
    function id = find_next_point( id )                
        [ ~, id ] = min( D( :, id ) );
    end
    
end


function [ X, Y, Z ] = to_matrices( obj )
%TO_MATRICES Returns the cells boundary polygons as 3 matrices padded by NaNs.

    n_obj = numel( obj.epicells );
    
    boundaries = { obj.epicells.boundary }';
    n_points = cellfun( @(c) size(c,1), boundaries );
    max_n_poins = max( n_points );
    
    % 1 column per polygon.
    X = zeros( max_n_poins + 1, n_obj );
    Y = zeros( max_n_poins + 1, n_obj );
    Z = zeros( max_n_poins + 1, n_obj );
    
    for i = 1 : n_obj
        
        P = boundaries{ i };
        np = n_points(i);
        X( 1 : np, i ) = P( : , 1 );
        Y( 1 : np, i ) = P( : , 2 );
        Z( 1 : np, i ) = P( : , 3 );
    
        X( np + 1 : end, i ) = P( 1 , 1 );
        Y( np + 1 : end, i ) = P( 1 , 2 );
        Z( np + 1 : end, i ) = P( 1 , 3 );

    end

end

